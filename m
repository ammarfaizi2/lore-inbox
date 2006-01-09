Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751606AbWAIXel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbWAIXel (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 18:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbWAIXel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 18:34:41 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:48275 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751320AbWAIXek convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 18:34:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fakAguRs4pwGHboUA4pikf/Let0YSnSwKeyNH2f6CpaaKT8/v0QM4juIHKerqZSYN0pZ5iFdG60eESY8iUny6OSLxN4s6lAfl71xeQjBYYYJcPXYqasAgeCOK1e2ZsK2jZtG3EmSJDhvnf1GfTnv/68a6+2Gur/d9yYKlmVOdy0=
Message-ID: <46a038f90601091534s7f4b36a5he05778f1ed82f34@mail.gmail.com>
Date: Tue, 10 Jan 2006 12:34:39 +1300
From: Martin Langhoff <martin.langhoff@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on Linux/ACPI release tree
Cc: Luben Tuikov <ltuikov@yahoo.com>, "Brown, Len" <len.brown@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>, Junio C Hamano <junkio@cox.net>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0601091502200.5588@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
	 <Pine.LNX.4.64.0601091502200.5588@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Using many branches in the same tree is
> definitely the better approach for _distribution_, but that doesn't
> necessarily mean that it's the better one for development.
(...)
> So git certainly supports that kind of behaviour, but nobody I know
> actually does it that way

Hrm! We do. http://locke.catalyst.net.nz/gitweb?p=moodle.git;a=heads
shows a lot of heads that share 99% of the code. The repo is ~90MB --
and we check each head out with cogito, develop and push. It is a
shared team repo, using git+ssh and sticky gid and umask 002.

Works pretty well I have to add. The only odd thing is that the
fastest way to actually start working on a new branch is to ssh on to
the server and cp moodle.git/refs/heads/{foo,bar} and then cg-clone
that bar branch away. Perhaps I should code up an 'cg-branch-add
--in-server' patch.

regards,


martin
