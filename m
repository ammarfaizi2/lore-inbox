Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSGQQTz>; Wed, 17 Jul 2002 12:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315375AbSGQQTz>; Wed, 17 Jul 2002 12:19:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22943 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S315370AbSGQQTy>;
	Wed, 17 Jul 2002 12:19:54 -0400
Date: Thu, 18 Jul 2002 18:21:41 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: shreenivasa H V <shreenihv@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gang Scheduling in linux
In-Reply-To: <20020716225441.23939.qmail@uwdvg008.cms.usa.net>
Message-ID: <Pine.LNX.4.44.0207181818300.29003-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Jul 2002, shreenivasa H V wrote:

> I wanted to know whether there is any support for gang scheduling in the
> linux kernel. If so, what is the status of the implementation and if
> there are any documents about the same.

yes - the 'synchronous wakeup' feature is a form of gang scheduling. It in
essence uses real process-communication information to migrate 'related'
tasks to the same CPU. So it's automatic, no need to declare processes to
be part of a 'gang' in some formal (and thus fundamentally imperfect) way.

(another form of 'gang scheduling' can be achieved by binding the 'parent'
process to a single CPU - all children will be bound to that CPU as well.)

	Ingo

