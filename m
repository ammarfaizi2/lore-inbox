Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbTH3NgN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 09:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbTH3NgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 09:36:13 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:39780 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261588AbTH3NgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 09:36:10 -0400
Date: Sat, 30 Aug 2003 14:35:09 +0100
From: Dave Jones <davej@redhat.com>
To: Matt Gibson <gothick@gothick.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 and hardware reports a non fatal incident
Message-ID: <20030830133509.GA686@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matt Gibson <gothick@gothick.org.uk>, linux-kernel@vger.kernel.org
References: <200308281548.44803.tomasz_czaus@go2.pl> <20030828151708.0b13dd82.rddunlap@osdl.org> <200308301149.19944.gothick@gothick.org.uk> <200308301344.56545.gothick@gothick.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308301344.56545.gothick@gothick.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 01:44:56PM +0100, Matt Gibson wrote:
 > > 	for (i=1; i<nr_mce_banks; i++) {
 > >
 > > Check out the "for".  Or am I reading this wrong?
 > 
 > Having checked back, this was changed between test-2 and test-3.  The 
 > checking code in k7_machine_check() still loops from 0 rather than 1.  I 
 > think this may be leading to false reporting of problems, which may be why I 
 > and Tomasz are seeing these MCE messages on our Athlons.

When it was i=0 people were seeing false positives. Starting from 1
reduces that.

 > Anyone who knows more about this stuff care to comment?  Is someone looking 
 > after MCE at the moment?  I couldn't find out much info on it.

in the past, Alan and myself took care of i386, Andi Kleen did AMD64.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
