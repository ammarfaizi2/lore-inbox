Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbVJ0VUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbVJ0VUd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbVJ0VUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:20:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:5519 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932638AbVJ0VUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:20:32 -0400
Date: Thu, 27 Oct 2005 23:20:31 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Fao, Sean" <sean.fao@capitalgenomix.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kconfig and lxdialog, kernel 2.6.13.4
In-Reply-To: <4360FB41.8070403@capitalgenomix.com>
Message-ID: <Pine.LNX.4.61.0510272312380.1386@scrub.home>
References: <4360FB41.8070403@capitalgenomix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Oct 2005, Fao, Sean wrote:

BTW your patch is white space damaged and wordwrapped.

> @@ -92,14 +96,22 @@ int dialog_yesno(const char *title, cons
>         case 'n':
>             delwin(dialog);
>             return 1;
> -
> +    case 'A':
> +    case 'a':
> +      if (btn_t == YESNOABORT)
> +      {
> +        delwin(dialog);
> +        return 2;
> +      }
> +      break;

Actually it's already possible to abort the dialog by pressing Esc. I 
don't mind the abort button, but please match the Esc behaviour and return 
-1.

bye, Roman
