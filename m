Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVFBCKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVFBCKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 22:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVFBCKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 22:10:13 -0400
Received: from main.gmane.org ([80.91.229.2]:3501 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261569AbVFBCKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 22:10:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Date: Thu, 02 Jun 2005 04:08:39 +0200
Message-ID: <yw1x8y1tzf14.fsf@ford.inprovide.com>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl>
 <429B0683.nail5764GYTVC@burner>
 <46BE0C64-1246-4259-914B-379071712F01@mac.com>
 <429C4483.nail5X0215WJQ@burner> <20050531172204.GD17338@voodoo>
 <d120d500050531122879868bae@mail.gmail.com>
 <429DDA07.nail7BFA4XEC5@burner>
 <d120d50005060109051f9ade82@mail.gmail.com>
 <429DEA5B.nail7BFNJVI78@burner> <429DF038.3010503@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:d6MdPnDg5oJid1LXNLfPRVxbrII=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortel.com> writes:

> Joerg Schilling wrote:
>
>> There is still no new and definitely stable interface that allows me to
>> asume that it makes sense to put effort in implementing support for it.
>
> Why not just accept *any* device node that the user passes in?

That's the question I think we're all asking.  The answer is that
cdrecord *already* does this.

In my understanding there are three basic parts involved here: 1) SCSI
commands, and the devices that use them, 2) low-level
addressing/transport used by the OS to deliver SCSI commands to the
devices, and 3) high-level addressing used by userland when talking to
the OS.  2 can be more or less anything: traditional b/t/l SCSI,
ATAPI, parport, USB, etc, each with it's own unique addressing style.
3 is what applications should be using, and varies across OSes, Unix
systems using device nodes, others using other methods I do not know.
Through a thorough misunderstanding of the word "portable",
Mr. Schilling appears to be attempting to forcibly extend one
particular incarnation of 2 to also cover 3.

FWIW, I run cdrecord using dev=/dev/cdrw as a regular user, without
any suid bits, and close my eyes while the warnings scroll by.  Using
a small window and the -v flag, they're out of sight before you know
it.  I have yet to burn a coaster not resulting from bad media or
hardware, even on loaded systems, over NFS, or whatnot.

-- 
Måns Rullgård
mru@inprovide.com

