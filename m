Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261388AbSJHRKm>; Tue, 8 Oct 2002 13:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261389AbSJHRKl>; Tue, 8 Oct 2002 13:10:41 -0400
Received: from [66.70.28.20] ([66.70.28.20]:34063 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S261388AbSJHRKj>; Tue, 8 Oct 2002 13:10:39 -0400
Date: Tue, 8 Oct 2002 19:07:16 +0200
From: DervishD <raul@pleyades.net>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dead processes
Message-ID: <20021008170716.GK45@DervishD>
References: <20021008184024.27c95217.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021008184024.27c95217.gigerstyle@gmx.ch>
User-Agent: Mutt/1.4i
Organization: Pleyades Net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Marc :)

>  4260 ?        Z      0:00 [gpg <defunct>]
> There are a lot of defunct processes which I can't kill.
> How comes? Normal? Solution?

    They are 'Zombie' processes. At some point they will be
reparented to 'init' and it will get rid of them. Those processes are
dead but nobody has 'wait()'ed for them. 'init' will do ASAP. The
problem is if they aren't reparented to init.

    Raúl
