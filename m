Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131953AbRDTTYc>; Fri, 20 Apr 2001 15:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131942AbRDTTYW>; Fri, 20 Apr 2001 15:24:22 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:6574 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S131953AbRDTTYK>;
	Fri, 20 Apr 2001 15:24:10 -0400
To: root@chaos.analogic.com
Cc: Victor Zandy <zandy@cs.wisc.edu>, linux-kernel@vger.kernel.org,
        pcroth@cs.wisc.edu, epaulson@cs.wisc.edu
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <Pine.LNX.3.95.1010420145755.11087A-100000@chaos.analogic.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 20 Apr 2001 12:23:16 -0700
In-Reply-To: "Richard B. Johnson"'s message of "Fri, 20 Apr 2001 15:07:28 -0400 (EDT)"
Message-ID: <m3n19bs7dn.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> If it "fixes" it, there is no problem with the FPU, but with the
> 'C' runtime library which doesn't initialize the FPU to a known
> state before it uses it.

It's the kernel which initializes the FPU.  This was always the case
and necessary to implement the fast lazy FPU saving/restoring.
Processes which never use the FPU never initialize it.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
