Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313551AbSDLLlS>; Fri, 12 Apr 2002 07:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313552AbSDLLlR>; Fri, 12 Apr 2002 07:41:17 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:30472 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313551AbSDLLlR>;
	Fri, 12 Apr 2002 07:41:17 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: KVM Switch bug 
In-Reply-To: Your message of "Thu, 11 Apr 2002 20:50:36 +0200."
             <200204112050.37043.sverrept@vub.ac.be> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Apr 2002 21:41:03 +1000
Message-ID: <17100.1018611663@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2002 20:50:36 +0200, 
Stijn Verrept <sverrept@vub.ac.be> wrote:
>When switching using a KVM switch I loose keyboard (only in Linux so it's not 
>hardware related)

For flakey KVMs, I define a user (switched) in /etc/passwd with the
same uid/gid as root and no password.  Instead of a normal shell, its
login entry is /usr/local/bin/switched which contains

#!/bin/sh
/etc/rc.d/init.d/gpm restart
/sbin/kbdrate -r 30

If there are any problems I log in as user switched, either keyboard or
network.  The script runs to reset mouse and keyboard then the user
exits.  The lack of password means that anybody can reset the KVM
devices to fix problems.

