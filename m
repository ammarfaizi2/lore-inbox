Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315368AbSDXDqr>; Tue, 23 Apr 2002 23:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSDXDqq>; Tue, 23 Apr 2002 23:46:46 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:55940 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S315368AbSDXDqq>; Tue, 23 Apr 2002 23:46:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Michael D. Johnson" <mike@C242326-a.attbi.com>
Reply-To: mikej163@attbi.com
To: A Guy Called Tyketto <tyketto@wizard.com>
Subject: Re: PROBLEM:  make xconfig fails on link
Date: Tue, 23 Apr 2002 20:46:35 -0700
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020423232908.33CF556A5A@C242326-a.attbi.com> <20020424031900.GA6731@wizard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020424034642.12C5D56A5A@C242326-a.attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Brad, 
I took your advice and went back and examined the 2.4.18 release and it too 
had the logic as != "y".  Also when I changed mine to be the same != "y" up 
it came.   Looks to me with two of us confirming it, it probably needs to be 
fixed at the source.   Thanks.  If I run into again, I'll check that logic 
first.
Mike


On Tuesday 23 April 2002 20:19, A Guy Called Tyketto wrote:
{snip include}
>
>         I had the same problem with xconfig when I rolled 2.5.9. A bit more
> looking into it made me wonder about the conditional of Config.in on that
> line. Currently shows:
>
> if [ "$CONFIG_ISDN_BOOL" == "y" ]; then
>
>         I reversed this condition to make it != "y", and it worked. See
> below for patch. I'm not sure if this is correct, because I'm not that
> familiar with it (though I should!) but it made make xconfig work for me
> again. YMMV.
>
>                                                         BL.
>
> --- linux/drivers/isdn/Config.in.borked	Tue Apr 23 20:12:58 2002
> +++ linux/drivers/isdn/Config.in	Mon Apr 22 18:46:45 2002
> @@ -7,7 +7,7 @@
>  if [ "$CONFIG_NET" != "n" ]; then
>     bool 'ISDN support' CONFIG_ISDN_BOOL
>
> -   if [ "$CONFIG_ISDN_BOOL" == "y" ]; then
> +   if [ "$CONFIG_ISDN_BOOL" != "y" ]; then
>        mainmenu_option next_comment
>        comment 'Old ISDN4Linux'
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8xiqfod000q4aikwRAnXpAJ4njsIyw31AiyFVIwJVdH6r+no8hwCfcuZK
uv7raV0mh1hVj3RWpW4ftIE=
=1S1s
-----END PGP SIGNATURE-----
