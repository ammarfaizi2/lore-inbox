Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTDTQqy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 12:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbTDTQqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 12:46:53 -0400
Received: from 12-211-64-22.client.attbi.com ([12.211.64.22]:64390 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S263628AbTDTQqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 12:46:53 -0400
Message-ID: <3EA2D1C9.5030707@comcast.net>
Date: Sun, 20 Apr 2003 09:58:49 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030419
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: admin@brien.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re:  my dual channel DDR 400 RAM won't work on any linux distro
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you perhaps have a video card with 128MB on board? I had the same
symptoms as you, and it turned out to be the vesafb driver. It basically
tries to ioremap the entire framebuffer and can't fit it in the reserved
area because it's only 128MB. You can either boot with vga=0 or some
such text mode, which disables the vesafb, or patch vesafb to only
ioremap the space needed for the video mode selected. BTW, the same
applies to rivafb and others I suspect, if your video card has 128MB ram.

-Walt

