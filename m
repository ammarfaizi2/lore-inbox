Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287999AbSABXaR>; Wed, 2 Jan 2002 18:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287169AbSABX2p>; Wed, 2 Jan 2002 18:28:45 -0500
Received: from [217.9.226.246] ([217.9.226.246]:53632 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S287976AbSABX1f>; Wed, 2 Jan 2002 18:27:35 -0500
To: paulus@samba.org
Cc: Bernard Dautrevaux <Dautrevaux@microprocess.com>,
        "'Tom Rini'" <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E3ED@IIS000>
	<15411.37236.181936.39729@argo.ozlabs.ibm.com>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <15411.37236.181936.39729@argo.ozlabs.ibm.com>
Date: 03 Jan 2002 01:27:42 +0200
Message-ID: <87d70suydt.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Paul" == Paul Mackerras <paulus@samba.org> writes:
Paul> As I said in another email, if the gcc maintainers want to change gcc
Paul> so that pointer arithmetic can do anything other than an ordinary 2's
Paul> complement addition operation, 

Nobody changes pointer arithmetic. The problem is that this
optimization gives _negative_ length, because the resulting pointer
does not point inside or one past the end of the array, which in turn
is explicitly mentioned in the standard as undefined behavior.

Paul> ... then we will stop using gcc.

Specifically separated this part to state that I don't even care to
comment on this. Doh, I did. Anyway ..

Regards,
-velco

