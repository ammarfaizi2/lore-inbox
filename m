Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbTEHQkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbTEHQkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:40:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19698 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261843AbTEHQkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:40:08 -0400
Message-ID: <3EBA8B04.5010704@us.ibm.com>
Date: Thu, 08 May 2003 09:51:16 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Jonathan Lundell <linux@lundell-bros.com>, root@chaos.analogic.com,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]> <3EB957FA.4080900@us.ibm.com> <20030507200647.GB3166@wohnheim.fh-wedel.de> <3EB96916.7080900@us.ibm.com> <20030508084101.GE1469@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> If I read this correctly, your patch doesn't catch everything, if
> there are functions remaining that use stack frames >0x200ul.  Ok,
> tell me I'm wrong and should go through the assembler code first.

If any function is ever called with < 0x200 bytes of space left on the
stack, it considers it an overflow.

-- 
Dave Hansen
haveblue@us.ibm.com

