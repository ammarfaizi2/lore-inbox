Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265537AbSJXQkp>; Thu, 24 Oct 2002 12:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265538AbSJXQkp>; Thu, 24 Oct 2002 12:40:45 -0400
Received: from [206.124.139.154] ([206.124.139.154]:40205 "EHLO
	grieg.holmsjoen.com") by vger.kernel.org with ESMTP
	id <S265537AbSJXQko>; Thu, 24 Oct 2002 12:40:44 -0400
Date: Thu, 24 Oct 2002 09:46:13 -0700
From: Randolph Bentson <bentson@grieg.holmsjoen.com>
To: Frank Cornelis <fcorneli@elis.rug.ac.be>
Cc: linux-kernel@vger.kernel.org, Frank.Cornelis@elis.rug.ac.be
Subject: Re: Resource limits
Message-ID: <20021024094613.A2727@grieg.holmsjoen.com>
References: <Pine.LNX.4.44.0210241357350.14267-100000@trappist.elis.rug.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210241357350.14267-100000@trappist.elis.rug.ac.be>; from fcorneli@elis.rug.ac.be on Thu, Oct 24, 2002 at 02:13:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 02:13:01PM +0200, Frank Cornelis wrote:
> This way a parent process is able to temporary drop some of its
> limits in order to make a restricted child process and restore
> its resource limits afterwards. Currenly it is not possible to
> make a child process with smaller resource limits than the parent
> process without the parent process losing its (hard) max limits
> (As far as I know, correct me if I'm wrong).

Hmm, this statement suggests the author misunderstands the Unix-based
conventional use of the separated fork/exec calls.  After the fork
call, the child process is still running code common to the parent,
but typically (by convention) a different leg of an if-then-else
statement.  This code in this leg can reduce resource limits before
make an exec call to start a new program.  The parent's limits are
not affected.  There's no need to change the kernel.

-- 
Randolph Bentson
bentson@holmsjoen.com
