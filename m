Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267610AbTACRwJ>; Fri, 3 Jan 2003 12:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267609AbTACRwI>; Fri, 3 Jan 2003 12:52:08 -0500
Received: from mailout6-0.nyroc.rr.com ([24.92.226.125]:31985 "EHLO
	mailout6-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S267608AbTACRwG> convert rfc822-to-8bit; Fri, 3 Jan 2003 12:52:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Stephen Evanchik <evanchsa@clarkson.edu>
To: Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [PATCH 2.5.54] hermes: serialization fixes
Date: Fri, 3 Jan 2003 12:56:41 -0500
User-Agent: KMail/1.4.1
References: <200301031239.29226.evanchsa@clarkson.edu> <20030103124754.A16519@redhat.com>
In-Reply-To: <20030103124754.A16519@redhat.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301031256.41451.evanchsa@clarkson.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 January 2003 12:47, you wrote:
|  Why not put the spinlock/unlock inside hermes_bap_seek()?  Smaller, better
|  contained and more readable.

That's the better solution, I'm trying to coordinate a bit with the 
maintainer. The only reason I didn't do this in the first place is because 
there is a (possibly unecessary) delay loop inside hermes_bap_seek that I 
believe is trying to combat the same problem. I'm awaiting a response from 
the maintainer since he knows a bit more about the hardware than I do.


Stephen

