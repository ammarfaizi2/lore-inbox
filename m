Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbTEAWTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 18:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbTEAWTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 18:19:08 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:56489 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262728AbTEAWTC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 18:19:02 -0400
Message-ID: <3EB1A029.7080708@nortelnetworks.com>
Date: Thu, 01 May 2003 18:31:05 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: =?ISO-8859-1?Q?P=E5l?= Halvorsen <paalh@ifi.uio.no>
Cc: Mark Mielke <mark@mark.mielke.cc>, bert hubert <ahu@ds9a.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: sendfile
References: <Pine.LNX.4.51.0304301604330.12087@sondrio.ifi.uio.no> <20030430165103.GA3060@outpost.ds9a.nl> <Pine.SOL.4.51.0304302102300.12387@ellifu.ifi.uio.no> <20030430192809.GA8961@outpost.ds9a.nl> <Pine.SOL.4.51.0304302317590.13406@thrir.ifi.uio.no> <20030430221834.GA23109@mark.mielke.cc> <Pine.SOL.4.51.0305010024180.334@niu.ifi.uio.no> <20030501042831.GA26735@mark.mielke.cc> <Pine.SOL.4.51.0305012303540.17001@fjorir.ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pål Halvorsen wrote:

> As far as i understand mmap/send, you'll have a copy operation in the
> kernel here. mmap shares the kernel and user buffer, but when sending the
> packet data is copied to the socket buffer!!??

Yes, there is a copy there.

> OK, but I understand that my streaming scenario is not the target
> application for sendfile.

What stops you from using sendfile (with TCP) to each destination separately, 
with the client only reading from the pipe as needed (presumably with a number 
of frames worth of buffer on the client side)?


Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

