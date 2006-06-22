Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030509AbWFVCYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030509AbWFVCYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 22:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbWFVCYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 22:24:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47831 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030509AbWFVCYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 22:24:17 -0400
Date: Wed, 21 Jun 2006 22:24:14 -0400
From: Dave Jones <davej@redhat.com>
To: keith mannthey <kmannth@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] patch [1/1]  convert i386 summit subarch to use SRAT data for apicid_to_node
Message-ID: <20060622022414.GB4449@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	keith mannthey <kmannth@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <1150941296.10001.25.camel@keithlap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150941296.10001.25.camel@keithlap>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 06:54:55PM -0700, keith mannthey wrote:
 > Hello All,
 >   This patch converts the i386 summit subarch apicid_to_node to use node
 > information provided by the SRAT.  The current way of obtaining the
 > nodeid 
 > 
 >  static inline int apicid_to_node(int logical_apicid)
 >  { 
 >    return logical_apicid >> 5;
 >  }
 > 
 > is just not correct for all summit systems/bios.  Assuming the apicid
 > matches the Linux node number require a leap of faith that the bios lay-
 > ed out the apicids a set way.  Modern summit HW does not layout its bios
 > in the manner for various reasons and is unable to boot i386 numa.
 > 
 >   The best way to get the correct apicid to node information is from the
 > SRAT table. 

Do all summit's have SRAT tables ?
I was under the impression the early ones were around before
the invention of SRAT.

		Dave

-- 
http://www.codemonkey.org.uk
