Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272257AbTHDXAk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272279AbTHDXAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:00:40 -0400
Received: from grieg.holmsjoen.com ([206.124.139.154]:25870 "EHLO
	grieg.holmsjoen.com") by vger.kernel.org with ESMTP id S272257AbTHDXAj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:00:39 -0400
Date: Mon, 4 Aug 2003 16:00:09 -0700
From: Randolph Bentson <bentson@holmsjoen.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Jesse Pollard <jesse@cats-chateau.net>, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-ID: <20030804160009.B3751@grieg.holmsjoen.com>
References: <20030804141548.5060b9db.skraw@ithnet.com> <03080409334500.03650@tabby> <20030804170506.11426617.skraw@ithnet.com> <03080416092800.04444@tabby> <20030805003210.2c7f75f6.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030805003210.2c7f75f6.skraw@ithnet.com>; from skraw@ithnet.com on Tue, Aug 05, 2003 at 12:32:10AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 12:32:10AM +0200, Stephan von Krawczynski wrote:
> And in just the same way fs could provide a mode bit saying "hi, I am a
> hardlink", and tar can then easily provide option number 1345 saying
> "stay away from hardlinks".

Perhaps not a bit, but rather another enumerated value in the type field
of an inode.  (Are there any values left?)

Ok, lets consider this.  Suppose that /a/b and /a/c both refer to the same
directory, where /a/b is a traditional link, but /a/c is a "hardlink".

What happens when one executes 'rmdir /a/b'?  Does the directory it
references disappear?  If not, how would tar ever find it?  (I have
this vision of a disk full of these hardlink-only directories which
tar and perhaps fsck cannot find.)

-- 
Randolph Bentson
bentson@holmsjoen.com
