Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264973AbSJPIeD>; Wed, 16 Oct 2002 04:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbSJPIeD>; Wed, 16 Oct 2002 04:34:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51578 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264973AbSJPIeC> convert rfc822-to-8bit; Wed, 16 Oct 2002 04:34:02 -0400
To: Eduardo PXrez <100018135@alumnos.uc3m.es>
Cc: Marius Gedminas <mgedmin@centras.lt>, linux-kernel@vger.kernel.org
Subject: Re: fork() wait semantics
References: <20021015115517.GA2514@atrey.karlin.mff.cuni.cz>
	<34f5602687bbb910752d5becee9c9aa1@alumnos.uc3m.es>
	<20021015180743.GD7511@gintaras>
	<a074067cb9f2b74a80a9f9f03f0abcaa@alumnos.uc3m.es>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Oct 2002 02:38:29 -0600
In-Reply-To: <a074067cb9f2b74a80a9f9f03f0abcaa@alumnos.uc3m.es>
Message-ID: <m1u1jm3hiy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduardo PXrez <100018135@alumnos.uc3m.es> writes:

> On 2002-10-15 20:07:43 +0200, Marius Gedminas wrote:
> > On Tue, Oct 15, 2002 at 04:58:44PM +0000, Eduardo Pérez wrote:
> > > As an example consider bash. In case of fork() error the program
> > > isn't even run thus causing a fatal error. If fork() waited for
> > > resources to be available there wouldn't be any problem.
> > 
> > No, thank you.  This happened to me more than once (runaway fetchmail
> > plugins).  An error message about a failing fork() indicates
> > immediately that I have too many processes, and I can kill them
> > (thankfully kill is a bash builtin).  If bash just waited silently I
> > wouldn't know what to think.
> 
> But you are talking about buggy software.
> If you software has bugs don't expect it to work properly.
> 
> These fork() semantics are for non-buggy software.

Well that clinches it since there is no non-buggy software we
definitely don't want that behavior.

Eric
