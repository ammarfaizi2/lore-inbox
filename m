Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289891AbSA3QP1>; Wed, 30 Jan 2002 11:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289456AbSA3QNd>; Wed, 30 Jan 2002 11:13:33 -0500
Received: from [216.247.238.190] ([216.247.238.190]:24589 "HELO
	pakistanmail.com") by vger.kernel.org with SMTP id <S289383AbSA3QMv>;
	Wed, 30 Jan 2002 11:12:51 -0500
From: grumph@pakistanmail.com
Reply-to: grumph@pakistanmail.com
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, hpa@zytor.com
Date: Wed, 30 Jan 2002 18:09:22 +0100
Subject: Re: Wanted: Volunteer to code a Patchbot
Message-id: <3c580adc.3d7c.0@pakistanmail.com>
X-User-Info: 217.70.229.45
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did some thinking just before this thread surfaced.

What can a patchbot be trusted to do properly?  (see below)
---------------------------------------------------
Linus got his style of working and he's got no intention whatsoever to
change that. So what is needed is a bot that works according to Linus' 
taste, but goes behind his back when it comes to informing the poor 
patch submitters....

As always, simplicity rules. 

None of this relies on a bot handling actual patching of code in the
tree. A live, human (most of you, I assume) being will have to review
and manually apply the patch.

None of this requires Linus to change his habits, he could still apply
any patches sent to torvalds@transmeta. Trusted people could still send
Linus patches directly.

But the newbies and untrusted guys without an established relationship to
a trusted kernel developer get a little help to keep their patch updated. 

It is not going to help on bad person chemistry or bad code. But it
could weed out the obvious non-starters and help people get it right,
without bothering busy kernel developers.


What can a patchbot be trusted to do properly?
---------------------------------------------------
- receive mail sent to: patch-2.5-linus@kernel or patch-2.4-marcelo@kernel
 (you get the idea; version and tree)
- patch-id assignment for tracking of patches accepted by bot
- sender authentication/confirmation, as for mailing list subscriptions
- verify that patch 
	- applies to latest tree
	- isn't oversized (by some definition)
	- is correctly formatted
	- contains a rationale (in some predefined format)
- route patch to correct maintainer(s), based on the files it touches
	(may require some initial work)
- inform sender that patch was forwarded to <maintainer>
- inform sender that patch was automatically rejected because it:
	- does not apply to latest tree
	- is too big/touches too many files
	- does not compile (hardware reqs.? OSD labs?)
	- does not contain aforementioned rationale
	- isn't formatted according to CodingStyle (Does current code?)
- inform sender that patch did not end up in next snap of tree, 
	possibly because of:
	- conflict with other patch
	- a human didn't like the taste of it (-EBADTASTE)
	- maintainer has not reviewed the patch yet
	(use the above assigned patch-id to detect if patch was applied)
- ask sender to rediff, review and resubmit patch 
  The bot could do this by itself. But it isn't linus-style.
  The sender should maintain his own patch.
- inform the sender how to kill a patch-id from being processed	
- automatically kill patch-ids from being processed if sender does not 
  respond within <time>
- killfile abusers (needs policy)
- publish patches on kernel.org and linux-kernel as they come in.
----------------------------------------------------------

Will Linus immediately killfile mail sent from this bot?
Will hpa host it at kernel.org?
Will someone write the code if it gets thumbs up from linus/hpa?
Is it going to make a difference?

_______________________________________________________________________
Get your free @pakistanmail.com email address   http://pakistanmail.com
