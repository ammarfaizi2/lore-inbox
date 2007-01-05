Return-Path: <linux-kernel-owner+w=401wt.eu-S1750784AbXAEVW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbXAEVW3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 16:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbXAEVW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 16:22:29 -0500
Received: from kirby.webscope.com ([204.141.84.54]:47827 "EHLO
	kirby.webscope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbXAEVW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 16:22:28 -0500
Message-ID: <459EC16F.1070809@linuxtv.org>
Date: Fri, 05 Jan 2007 16:21:51 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Robert Fitzsimons <robfitz@273k.net>
CC: "J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Krufky <mkrufky@gmail.com>
Subject: Re: [PATCH] gitweb: Fix shortlog only showing HEAD revision.
References: <459C0232.3090804@linuxtv.org> <20070103202555.GA25768@localhost>
In-Reply-To: <20070103202555.GA25768@localhost>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Fitzsimons wrote:
> My change in 190d7fdcf325bb444fa806f09ebbb403a4ae4ee6 had a small bug
> found by Michael Krufky which caused the passed in hash value to be
> ignored, so shortlog would only show the HEAD revision.
> 
> Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
> ---
> 
> Thanks for finding this Michael.  It' just a small bug introducted by a
> recent change I made.  Including John 'Warthog9' so hopefully he can add
> this to the version of gitweb which is hosted on kernel.org.
> 
> Robert

Robert,

Thank you for fixing this bug so quickly.  I've noticed that the gitweb
templates on kernel.org have changed at least once since you wrote this email to
me... (I can tell, based on the fact that the git:// link has moved from the
project column to a link labeled, "git" all the way to the right.)

Unfortunately, however, the bug that I had originally reported has not yet been
fixed on the kernel.org www server.  Either the patch in question hasn't yet
been applied to that installation, or it HAS in fact been applied, but doesn't
fix the problem as intended.

Do you know which of the above is true?

Thanks again,

Mike Krufky

>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d845e91..2e94c2c 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4423,7 +4423,7 @@ sub git_shortlog {
>  	}
>  	my $refs = git_get_references();
>  
> -	my @commitlist = parse_commits($head, 101, (100 * $page));
> +	my @commitlist = parse_commits($hash, 101, (100 * $page));
>  
>  	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, (100 * ($page+1)));
>  	my $next_link = '';

