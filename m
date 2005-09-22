Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbVIVTkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbVIVTkS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbVIVTkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:40:18 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:6556 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030184AbVIVTkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:40:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=LgpNgku5+65Okcqhg2W+vWXRiV5FBbL2i4zWUAOWmRswXUXwYT+5SbtNSbL4bAkZTXtYTxtv+I62aAcwTJn65TzHgnBMTYWqZo1ttswdRSdi4JK/iExVXXrdIU/Byj1uWZj2B5/Xkw5yZLC8zAhBY51kCGTkxDEC3zg7W8JLmdw=
Date: Thu, 22 Sep 2005 23:50:29 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: tty update speed regression (was: 2.6.14-rc2-mm1)
Message-ID: <20050922195029.GA6426@mipter.zuzino.mipt.ru>
References: <20050921222839.76c53ba1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921222839.76c53ba1.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see regression in tty update speed with ADOM (ncurses based
roguelike) [1].

Messages at the top ("goblin hits you") are printed slowly. An eye can
notice letter after letter printing.

2.6.14-rc2 is OK.

I'll try to revert tty-layer-buffering-revamp*.patch pieces and see if
it'll change something.

[1] http://adom.de/adom/download/linux/adom-111-elf.tar.gz (binary only)

