Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbTD3MNS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 08:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTD3MNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 08:13:18 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39061
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262142AbTD3MNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 08:13:17 -0400
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Mercer <r.a.mercer@blueyonder.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20030430080910.GA5011@skymoo.dyndns.org>
References: <20030430080910.GA5011@skymoo.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051702003.19579.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Apr 2003 12:26:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-30 at 09:09, Adam Mercer wrote:
> -	video_size          = screen_info.lfb_size * 65536;

The above is correct. It returns the size of the frame buffer

> +	video_size          = screen_info.lfb_width *	screen_info.lfb_height * video_bpp;
> 	video_visual = (video_bpp == 8) ?
> 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;						#

The change computes the mode size. Thats probably safe for the ioremap
range

