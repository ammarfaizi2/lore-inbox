Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932757AbWFVDzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbWFVDzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 23:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWFVDzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 23:55:54 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:28879 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751292AbWFVDzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 23:55:53 -0400
Subject: Re: [RFC] patch [1/1]  convert i386 summit subarch to use SRAT
	data for apicid_to_node
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Dave Jones <davej@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060622022414.GB4449@redhat.com>
References: <1150941296.10001.25.camel@keithlap>
	 <20060622022414.GB4449@redhat.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Wed, 21 Jun 2006 20:55:51 -0700
Message-Id: <1150948551.10001.62.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 22:24 -0400, Dave Jones wrote:
> On Wed, Jun 21, 2006 at 06:54:55PM -0700, keith mannthey wrote:
>  > Hello All,
>  >   This patch converts the i386 summit subarch apicid_to_node to use node
>  > information provided by the SRAT.  The current way of obtaining the
>  > nodeid 
>  > 
>  >  static inline int apicid_to_node(int logical_apicid)
>  >  { 
>  >    return logical_apicid >> 5;
>  >  }
>  > 
>  > is just not correct for all summit systems/bios.  Assuming the apicid
>  > matches the Linux node number require a leap of faith that the bios lay-
>  > ed out the apicids a set way.  Modern summit HW does not layout its bios
>  > in the manner for various reasons and is unable to boot i386 numa.
>  > 
>  >   The best way to get the correct apicid to node information is from the
>  > SRAT table. 
> 
> Do all summit's have SRAT tables ?
> I was under the impression the early ones were around before
> the invention of SRAT.

That is a good point.  Let me check into the x440 (1st gen).  x445 x460
(2nd,3rd gen) uses SRAT for sure (these patches have been tested on
these systems).  

The x440 lists an srat but maybe it is using some special bios area.  I
will build a test kernel give it a whirl.  


> 		Dave
> 
-- 
keith mannthey <kmannth@us.ibm.com>
Linux Technology Center IBM

