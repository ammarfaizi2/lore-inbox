Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279952AbRKIQEG>; Fri, 9 Nov 2001 11:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279956AbRKIQD4>; Fri, 9 Nov 2001 11:03:56 -0500
Received: from cj46222-a.reston1.va.home.com ([65.1.136.109]:25561 "HELO
	sanosuke.troilus.org") by vger.kernel.org with SMTP
	id <S279952AbRKIQDq>; Fri, 9 Nov 2001 11:03:46 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: carlo@alinoe.com, linux-kernel@vger.kernel.org
Subject: Re: [ircu-development] Slow on high-MTU (local host) connections?
In-Reply-To: <20011107043425.A15045@alinoe.com>
	<20011106.195257.102576616.davem@redhat.com>
From: Entrope <entrope@users.sourceforge.net>
Date: 09 Nov 2001 11:04:23 -0500
In-Reply-To: <20011106.195257.102576616.davem@redhat.com>
Message-ID: <87r8r82ans.fsf@sanosuke.troilus.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following up on this: Carlo and I both tried disabling Nagle on the
sockets (both ends).  We still saw the same slow sending pattern.

On one end (the "ircu" process in Carlo's original mail), the send and
receive buffers (SO_SNDBUF, SO_RCVBUF) had been set to 8 KB each.  If
these are increased to be larger than the loopback MTU, it makes the
problem go away.  (On the other, "srvx" end, the buffer sizes were
kept at the default.)

Is this expected behavior?  If so, why?  (The references I've found on
the web suggest that the send and receive buffer sizes would only come
into play if Nagle were still enabled.)

-- Entrope
