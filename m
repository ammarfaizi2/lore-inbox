Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752651AbWAHRpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbWAHRpx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 12:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbWAHRpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 12:45:53 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30216 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1752651AbWAHRpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 12:45:52 -0500
Date: Sun, 8 Jan 2006 18:45:37 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: rusty@rustcorp.com.au, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modpost: Fix typo
Message-ID: <20060108174537.GC10990@mars.ravnborg.org>
References: <43C13593.6080509@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C13593.6080509@didntduck.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 10:53:55AM -0500, Brian Gerst wrote:
> SND_MAX should be FF_MAX
> 
> Signed-off-by: Brian Gerst <bgerst@didntduck.org>

Applied, though I have not found a way to actually check this one is
correct.

	Sam

> 
> ---
> commit 71bc7fe59ac4b225d6279af4f45affbc5f2eec1b
> tree d1789dd69878466807dc3612dc8643c8102bbcda
> parent 12a9d2c317f6447caa5c5ccd553780516369f701
> author Brian Gerst <bgerst@didntduck.org> Sun, 08 Jan 2006 10:52:26 -0500
> committer Brian Gerst <bgerst@didntduck.org> Sun, 08 Jan 2006 10:52:26 -0500
> 
>  scripts/mod/file2alias.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index e0eedff..be97caf 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -417,7 +417,7 @@ static int do_input_entry(const char *fi
>  		do_input(alias, id->sndbit, 0, SND_MAX);
>  	sprintf(alias + strlen(alias), "f*");
>  	if (id->flags&INPUT_DEVICE_ID_MATCH_FFBIT)
> -		do_input(alias, id->ffbit, 0, SND_MAX);
> +		do_input(alias, id->ffbit, 0, FF_MAX);
>  	sprintf(alias + strlen(alias), "w*");
>  	if (id->flags&INPUT_DEVICE_ID_MATCH_SWBIT)
>  		do_input(alias, id->swbit, 0, SW_MAX);
> 
> 
