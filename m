Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265193AbSJaGlo>; Thu, 31 Oct 2002 01:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbSJaGlo>; Thu, 31 Oct 2002 01:41:44 -0500
Received: from mail.gurulabs.com ([208.177.141.7]:53671 "EHLO
	mail.gurulabs.com") by vger.kernel.org with ESMTP
	id <S265193AbSJaGln>; Thu, 31 Oct 2002 01:41:43 -0500
Subject: Re: What's left over.
From: Dax Kelson <dax@gurulabs.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20021031062249.GB18007@tapu.f00f.org>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
	<Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com> 
	<20021031062249.GB18007@tapu.f00f.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Oct 2002 23:48:23 -0700
Message-Id: <1036046904.1521.74.camel@mentor>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-30 at 23:22, Chris Wedgwood wrote:
> On Thu, Oct 31, 2002 at 01:06:54AM -0200, Rik van Riel wrote:
> 
> > Personally I do think either the unlimited groups patch or ACLs are
> > needed in order to sanely run a large anoncvs setup.
> 
> Processes need to be a member of 20+ groups to make anoncvs work?
> Sounds like anoncvs is broken then.

Technically speaking you can achieve ACL like permissions/behavior using
the historical UNIX security model by creating a group EACH time you run
into a unique case permission scenario.

Without ACLs, if Sally, Joe and Bill need rw access to a file/dir, just
create another group with just those three people in.  Over time, of
course, this leads to massive group proliferation.  Without Tim Hockin's
patch, 32 groups is maximum number of groups a user can be a member of.

Dax

