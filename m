Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbTEBEHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 00:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbTEBEHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 00:07:20 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:38616 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261220AbTEBEHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 00:07:20 -0400
Message-ID: <3EB1F1CD.4060702@nortelnetworks.com>
Date: Fri, 02 May 2003 00:19:25 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
Cc: =?ISO-8859-1?Q?P=E5l?= Halvorsen <paalh@ifi.uio.no>,
       bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: sendfile
References: <Pine.LNX.4.51.0304301604330.12087@sondrio.ifi.uio.no> <20030430165103.GA3060@outpost.ds9a.nl> <Pine.SOL.4.51.0304302102300.12387@ellifu.ifi.uio.no> <20030430192809.GA8961@outpost.ds9a.nl> <Pine.SOL.4.51.0304302317590.13406@thrir.ifi.uio.no> <20030430221834.GA23109@mark.mielke.cc> <Pine.SOL.4.51.0305010024180.334@niu.ifi.uio.no> <20030501042831.GA26735@mark.mielke.cc> <Pine.SOL.4.51.0305012303540.17001@fjorir.ifi.uio.no> <3EB1A029.7080708@nortelnetworks.com> <20030502024147.GA523@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:

> As far as I understand, sendfile() still requires the data to get from the
> disk to a page in memory, similar to how send() referencing an mmap()'d page
> may cause a page fault, reading the data from disk to a page in memory. One
> copy each. I don't know of a kernel interface that lets data be copied from
> disk to ethernet card without involving a temporary copy to be in paged
> memory at some point in time... perhaps the iSCSI stuff can do this? I dunno.

According to this:

http://asia.cnet.com/builder/program/dev/0,39009360,39062783,00.htm

using sendfile() is easier on the CPU due to less trashing of the TLB.


I do get your point about protocol limitiations though.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

