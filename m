Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130180AbQKIF0L>; Thu, 9 Nov 2000 00:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130217AbQKIF0B>; Thu, 9 Nov 2000 00:26:01 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:1075 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130180AbQKIFZy>; Thu, 9 Nov 2000 00:25:54 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage - modutils design 
In-Reply-To: Your message of "08 Nov 2000 21:09:49 -0800."
             <8udbit$pne$1@cesium.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 Nov 2000 16:25:10 +1100
Message-ID: <4983.973747510@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Nov 2000 21:09:49 -0800, 
"H. Peter Anvin" <hpa@zytor.com> wrote:
>Remember that we cannot rely on ANY form of persistent storage to be
>available in the beginning; / may very well be readonly (on a ROM,
>say.)  Since that means that we can't rely on writable storage being
>available until at least one other filesystem has been mounted, it
>might as well be the standard for variable data, i.e. /var.

Agreed.  Default is /var/lib/modules-persist.  People who have a
separate /var partition that is mounted after modules are loaded can
use / and specify

persist /lib/modules/persist

in /etc/modules.conf.  If you have a separate /var and you do not want
to write to /, change your initialization scripts to load modules after
mounting /var.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
