Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312466AbSDELrg>; Fri, 5 Apr 2002 06:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312476AbSDELr0>; Fri, 5 Apr 2002 06:47:26 -0500
Received: from ns.suse.de ([213.95.15.193]:13841 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312466AbSDELrI>;
	Fri, 5 Apr 2002 06:47:08 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: socket write(2) after remote shutdown(2) problem ?
In-Reply-To: <20020405104733.GD16595@come.alcove-fr.suse.lists.linux.kernel> <20020405.024435.88131177.davem@redhat.com.suse.lists.linux.kernel> <20020405105509.GE16595@come.alcove-fr.suse.lists.linux.kernel> <20020405.030251.28451401.davem@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Apr 2002 13:47:05 +0200
Message-ID: <p73n0wis6yu.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:
> 
> But all of this is irrelevant.  When a server closes and says "send me
> no more data", this implies that the server told the client it doesn't
> want any more data.  If the client sends data, this is a gross fatal
> error, so TCP resets in FIN_WAIT{1,2} states.

Linux has one hole in this. When the reset arrives too late the pending
error is not passed up and propagated through shutdown/close.

-Andi

