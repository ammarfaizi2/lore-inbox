Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135827AbRDYH3j>; Wed, 25 Apr 2001 03:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135828AbRDYH3a>; Wed, 25 Apr 2001 03:29:30 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:1927 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S135827AbRDYH3W>; Wed, 25 Apr 2001 03:29:22 -0400
From: Christoph Rohland <cr@sap.com>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>, Alexander Viro <viro@math.psu.edu>,
        Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <200104241847.f3OIlc7T016933@webber.adilger.int>
Organisation: SAP LinuxLab
Date: 25 Apr 2001 09:25:19 +0200
In-Reply-To: <200104241847.f3OIlc7T016933@webber.adilger.int>
Message-ID: <m3bspla1b4.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Tue, 24 Apr 2001, Andreas Dilger wrote:
> On the other hand, sockets and shmem are both relatively large...

shmem is only large because the union is large. I introduced the
direct swap array of size SHMEM_NR_DIRECT simply to take advantage of
the union. We can decrease SHMEM_NR_DIRECT very easily. I am thinking
about 1 or 5 which would mean that we allocate an indirect block for
files bigger than 4k or 20k respectively.

The shmem_inode_info would then be 8 or 12 words.

Greetings
		Christoph


