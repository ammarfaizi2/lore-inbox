Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVCBNIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVCBNIT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 08:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVCBNIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 08:08:19 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:51091 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262282AbVCBNHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 08:07:41 -0500
To: lm@bitmover.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK] cvs export
References: <20050302011419.GA30790@bitmover.com>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 02 Mar 2005 13:07:20 +0000
Message-ID: <tnxhdjukxh3.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

lm@bitmover.com (Larry McVoy) wrote:
> One problem is that the set of files in patches may not be disjoint,
> the same file may participate in multiple patches.  I think we can handle
> that in the following way, we put multiple comments, one for each patch,
> so you'd see
>
> 	(Logical change 1.12345.5)
> 	(Logical change 1.12345.11)
> 	(Logical change 1.12345.79)

Since this is one commit, could you also add the $PATCH number in the
ChangeSet,v log file? For merge operations you get the commit logs
from the merged tree but they wouldn't be mapped to the "1.x.patch"
logical change.

Should the BKrev value in ChangeSet,v have a correspondent on the
bkbits.net site? For example, for the ChangeSet,v RCS revision
1.26418, BKrev is 41fe523ecAJ3I6z55zHXaAI1vsDZ8Q. This changeset is
actually a bundled patch containing several patches but the bkbits
seems to show an empty patch:

http://linux.bkbits.net:8080/linux-2.5/gnupatch@41fe523ecAJ3I6z55zHXaAI1vsDZ8Q
http://linux.bkbits.net:8080/linux-2.5/cset@41fe523ecAJ3I6z55zHXaAI1vsDZ8Q?nav=index.html

On a side note, is the ChangeSet,v file updated before or after (or
in the same commit) the source files are checked in? It would be
better if it is updated after a commit since this way you can
guarantee that for a given revision of this file you have all the
"logical changes" checked in.

Catalin

