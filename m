Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267252AbTBQSrD>; Mon, 17 Feb 2003 13:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbTBQSrD>; Mon, 17 Feb 2003 13:47:03 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:16915 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267252AbTBQSrD>;
	Mon, 17 Feb 2003 13:47:03 -0500
Date: Mon, 17 Feb 2003 19:57:00 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, sam@ravnborg.org,
       kai@tp1.ruhr-uni-bochum.de, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc for 2.5.59 bk
Message-ID: <20030217185700.GA27610@mars.ravnborg.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>, sam@ravnborg.org,
	kai@tp1.ruhr-uni-bochum.de, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <20030209125759.GA14981@kroah.com> <Pine.LNX.4.44.0302162057200.5217-100000@chaos.physics.uiowa.edu> <20030217180246.GA26112@mars.ravnborg.org> <1911.212.181.176.76.1045505249.squirrel@www.zytor.com> <3E512BCB.1010000@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E512BCB.1010000@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 01:36:59PM -0500, Jeff Garzik wrote:
>  
> +check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)

Will check_gcc be compatible across architectures?
If thats the case it should be moved to a common place.

Checking.....
The same type of trick is used for alpha and sparc* - 
so I will move it to the top-level makefile.

	Sam
