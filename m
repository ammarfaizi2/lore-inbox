Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVATDIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVATDIA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 22:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVATDIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 22:08:00 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:33185 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S261957AbVATDH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 22:07:58 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [PATCH] aoe: add documentation for udev users
To: Ed L Cashin <ecashin@coraid.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Greg K-H <greg@kroah.com>
Reply-To: 7eggert@gmx.de
Date: Thu, 20 Jan 2005 04:07:54 +0100
References: <fa.gl94rva.1tkib28@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1CrSfr-0001l2-Et@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed L Cashin <ecashin@coraid.com> wrote:

> +if test -z "$conf"; then
> +        conf="`find /etc -type f -name udev.conf 2> /dev/null`"
> +fi
> +if test -z "$conf" || test ! -r $conf; then
> +        echo "$me Error: could not find readable udev.conf in /etc" 1>&2
> +        exit 1
> +fi

This will fail and print
---
bash: test: etc/udev.conf: binary operator expected
---
if there is more than one udev.conf.

Fix: Always put quotes around variables.
