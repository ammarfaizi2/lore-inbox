Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWCIRIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWCIRIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWCIRIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:08:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14011 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750714AbWCIRII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:08:08 -0500
Date: Thu, 9 Mar 2006 12:07:40 -0500
From: Dave Jones <davej@redhat.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Subject: Re: filldir[64] oddness
Message-ID: <20060309170740.GA9876@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bryan O'Sullivan <bos@serpentine.com>,
	Al Viro <viro@ftp.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20060309042744.GA23148@redhat.com> <20060308.203204.115109492.davem@davemloft.net> <20060309044025.GS27946@ftp.linux.org.uk> <1141923743.17294.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141923743.17294.8.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 09:02:22AM -0800, Bryan O'Sullivan wrote:
 > On Thu, 2006-03-09 at 04:40 +0000, Al Viro wrote:
 > > On Wed, Mar 08, 2006 at 08:32:04PM -0800, David S. Miller wrote:
 > > 
 > > > I think coverity is being trigger happy in this case :-)
 > > 
 > > If that's coverity, I'm very disappointed and more than a little
 > > suspicious about the quality of their results.
 > 
 > About half of the ~50 reports I've looked at so far in their database
 > have been false positives.  In most of those cases, it's not obvious how
 > a checker might have gotten them right instead, though.

It seems to stumble quite a bit when faced with things that are
free'd when refcounts drop to zero. (skbs, and kobjects).

		Dave

-- 
http://www.codemonkey.org.uk
