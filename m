Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbULODrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbULODrD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 22:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbULODrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 22:47:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:51110 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261851AbULODq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 22:46:59 -0500
X-Authenticated: #10070094
Subject: Re: [PATCH] Re: Improved console UTF-8 support for the Linux
	kernel?
From: Simos Xenitellis <simos74@gmx.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1102920623.30543.1820.camel@linux.heathens.co.nz>
References: <1102920623.30543.1820.camel@linux.heathens.co.nz>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1103082353.4611.0.camel@kl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Dec 2004 03:45:54 +0000
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I tried the patch of Chris on Fedora Core 2 and here is my take, from
the user's point of view.

The patch works, surprisingly very well.
It can be easily intergrated to the various distributions simply by
modifying the /etc/sysconfig/i18n and /etc/sysconfig/keyboard
configuration files.

The system scripts essentially call the following two commands (assuming
we are already in Unicode mode):
% setfont <font-name> -m <console-screen-map>
% loadkeys <keymap>

For example: 
For Spanish:
% setfont latarcyrheb-sun16 -m 8859-1
% loadkeys es

For Finish:
% setfont latarcyrheb-sun16 -m 8859-1
% loadkeys fi

For Greek:
% setfont iso07u-16 -m 8859-7
% loadkeys gr

The character and key maps used are the "old" 8-bit versions. setfonts
loads a Unicode map with the "-u" options instead of "-m". Also, the key
maps for a few languages have been updates (for example, "gr-utf" for
Greek). The new files (very few) cannot be used here. No need to update
them ;-).

I tried a few languages and what follows shows characters produced from
the console with composing. I used "vim" as my editor.

gr: Greek    ά έ ί ό ύ ώ ϊ ϋ ϊ Ά Έ Ί Ή Ύ Ϋ
es: Spanish  ñ á é í ý ú ü ï ÿ ä ë
nl: Dutch    á é í ó ú ý à è ì ò ù
cz: Czech    ä ë ö
us-ascentos: á é í ó ú ý ä ë ï ö ü ÿ
cf: french-canadian  à è ì ò ù
fi: Finish   ä ë ï ö ü â ê î ô û
fr  French   â ê î ô û ä ë ï ö ü ÿ

Therefore, from the user's point of view the patch works.

Cheers,
Simos Xenitellis

