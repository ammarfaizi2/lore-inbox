Return-Path: <linux-kernel-owner+w=401wt.eu-S932110AbXACUwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbXACUwl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbXACUwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:52:41 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:51493 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbXACUwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:52:40 -0500
X-Greylist: delayed 1555 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 15:52:40 EST
Date: Wed, 3 Jan 2007 20:25:55 +0000
From: Robert Fitzsimons <robfitz@273k.net>
To: Michael Krufky <mkrufky@linuxtv.org>, "J.H." <warthog19@eaglescrag.net>
Cc: git@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Krufky <mkrufky@gmail.com>
Subject: [PATCH] gitweb: Fix shortlog only showing HEAD revision.
Message-ID: <20070103202555.GA25768@localhost>
References: <459C0232.3090804@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459C0232.3090804@linuxtv.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-0.012, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: robfitz@273k.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My change in 190d7fdcf325bb444fa806f09ebbb403a4ae4ee6 had a small bug
found by Michael Krufky which caused the passed in hash value to be
ignored, so shortlog would only show the HEAD revision.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---

Thanks for finding this Michael.  It' just a small bug introducted by a
recent change I made.  Including John 'Warthog9' so hopefully he can add
this to the version of gitweb which is hosted on kernel.org.

Robert


 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d845e91..2e94c2c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4423,7 +4423,7 @@ sub git_shortlog {
 	}
 	my $refs = git_get_references();
 
-	my @commitlist = parse_commits($head, 101, (100 * $page));
+	my @commitlist = parse_commits($hash, 101, (100 * $page));
 
 	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, (100 * ($page+1)));
 	my $next_link = '';
-- 
t1.gaaaa
