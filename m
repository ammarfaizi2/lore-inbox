Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261373AbSJHRHD>; Tue, 8 Oct 2002 13:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSJHRHC>; Tue, 8 Oct 2002 13:07:02 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:9206 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261373AbSJHRHC>; Tue, 8 Oct 2002 13:07:02 -0400
Date: Tue, 8 Oct 2002 13:12:38 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dead processes
Message-ID: <20021008131238.E27856@redhat.com>
References: <20021008184024.27c95217.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021008184024.27c95217.gigerstyle@gmx.ch>; from gigerstyle@gmx.ch on Tue, Oct 08, 2002 at 06:40:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Oct 08, 2002 at 06:40:24PM +0200, Marc Giger wrote:
> There are a lot of defunct processes which I can't kill.
> How comes? Normal? Solution?

Whatever program is spawning gpg needs to reap the processes as they die 
via wait4(), possibly by catching SIGCHLD.  You can see the relationship 
between processes with ps -axf.

		-ben
-- 
GMS rules.
