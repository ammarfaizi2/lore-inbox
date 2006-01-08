Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932753AbWAHSq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbWAHSq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbWAHSq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:46:56 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:11218 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932753AbWAHSq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:46:56 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
Date: Sun, 8 Jan 2006 17:34:27 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <0ISL003ZI97GCY@a34-mta01.direcway.com>
In-Reply-To: <0ISL003ZI97GCY@a34-mta01.direcway.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601081734.30349.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 04 January 2006 23:01, Ben Collins wrote:

> +static char *fgets_check_stream(char *s, int size, FILE *stream)
> +{
> +	char *ret = fgets(s, size, stream);
> +
> +	if (ret == NULL && feof(stream)) {
> +		printf(_("aborted!\n\n"));
> +		printf(_("Console input is closed. "));
> +		printf(_("Run 'make oldconfig' to update configuration.\n\n"));
> +		exit(1);
> +	}
> +
> +	return ret;
> +}

What problem does this solve? conf should finish normally anyway and just set 
everything to the default.

bye, Roman

