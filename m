Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWDLLAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWDLLAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 07:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWDLLAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 07:00:30 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:32707 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932156AbWDLLAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 07:00:30 -0400
Date: Wed, 12 Apr 2006 13:00:22 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org,
       sam@ravnborg.org
Subject: Re: [RFC/POC] multiple CONFIG y/m/n
In-Reply-To: <20060409220426.8027953a.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.64.0604121253540.32445@scrub.home>
References: <20060406224134.0430e827.rdunlap@xenotime.net>
 <87odzdh1fp.fsf@duaron.myhome.or.jp> <20060409220426.8027953a.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Apr 2006, Randy.Dunlap wrote:

> +void usage(char *progname)
> +{
> +	printf("%s [-o|-s|-d|-D|-n|-m|-y|-r] Kconfig_filename\n", progname);

|-D <config>|

> +	printf("  -o: oldconfig: ask only about new config symbols\n");
> +	printf("  -s: silentoldconfig: don't ask about any symbol values\n");

It does ask about them, but suppresses a lot of prints.

> +	printf("  -d: defconfig: use default symbol values\n");

To be precise it uses arch/$ARCH/defconfig as default values.

> +	printf("  -n: set unknown symbol values to 'n'\n");
> +	printf("  -m: set unknown symbol values to 'm'\n");
> +	printf("  -y: set unknown symbol values to 'y'\n");

It actually tries to set all values to n/m/y.

> @@ -546,8 +564,8 @@ int main(int ac, char **av)
>  			break;
>  		case 'h':
>  		case '?':
> -			printf("%s [-o|-s] config\n", av[0]);
> -			exit(0);
> +			usage(av[0]);
> +			break;

That's indeed a little obsolete. :-)

bye, Roman
