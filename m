Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263906AbRFMA1t>; Tue, 12 Jun 2001 20:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263922AbRFMA1j>; Tue, 12 Jun 2001 20:27:39 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:1808
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S263906AbRFMA1h>;
	Tue, 12 Jun 2001 20:27:37 -0400
To: John Martin <suntzu@stanford.edu>
Subject: Re: [PATCH] symlink.c
Message-ID: <992392024.3b26b3586645a@www.goop.org>
Date: Tue, 12 Jun 2001 17:27:04 -0700 (PDT)
From: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <Pine.GSO.4.31.0106121706490.25662-100000@epic20.Stanford.EDU>
In-Reply-To: <Pine.GSO.4.31.0106121706490.25662-100000@epic20.Stanford.EDU>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting John Martin <suntzu@stanford.edu>:
> this patch adds a check to make sure memory was allocated, returns an
> error code otherwise.

autofs4_dentry_ino doesn't allocate memory; it just extracts the fsdata pointer
from the dentry structure.  If it's returning NULL, then there's something else
wrong and you're papering over the symptoms.  Are you seeing this happen?

Linus, please don't apply this.

     J
