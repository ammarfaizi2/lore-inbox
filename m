Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbTHVCFD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 22:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbTHVCFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 22:05:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:4523 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262982AbTHVCE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 22:04:59 -0400
Message-ID: <3F457A19.8E8A1F65@gmx.de>
Date: Fri, 22 Aug 2003 04:04:09 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: "Bill J.Xu" <xujz@neusoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: "ctrl+c" disabled!
References: <036601c367e0$01adabc0$2a01010a@avwindows>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bill J.Xu" wrote:
>
> when I connect linux through serial port,and run a program such
> as "ping xxx.xxx.xxx.xxx",then I can not stop it by using "ctrl+c".
> and the only way is to telnet it,and kill that progress
> 
> why?

Try:

  stty -a

and check the intr setting.  Maybe it's set to DEL (^?).
You can correct it with:

  stty intr "^c"

Ciao, ET.
