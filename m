Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268726AbUJPN0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268726AbUJPN0m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 09:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268733AbUJPN0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 09:26:42 -0400
Received: from findaloan.ca ([66.11.177.6]:23699 "EHLO vhosts.findaloan.ca")
	by vger.kernel.org with ESMTP id S268726AbUJPN0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 09:26:40 -0400
Date: Sat, 16 Oct 2004 09:21:27 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Willy Tarreau <willy@w.ods.org>
Cc: Robert White <rwhite@casabyte.com>,
       "'David S. Miller'" <davem@davemloft.net>,
       "'Olivier Galibert'" <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041016132127.GB22851@mark.mielke.cc>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	Robert White <rwhite@casabyte.com>,
	"'David S. Miller'" <davem@davemloft.net>,
	'Olivier Galibert' <galibert@pobox.com>, linux-kernel@vger.kernel.org
References: <20041008064104.GF19761@alpha.home.local> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAf9vmEwEK20KyGtJj9HtARQEAAAAA@casabyte.com> <20041016102433.GA17984@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016102433.GA17984@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 12:24:33PM +0200, Willy Tarreau wrote:
> On Fri, Oct 15, 2004 at 03:42:55PM -0700, Robert White wrote:
> > > As I asked in a previous mail in this overly long thread, why not
> > > returning zero bytes at all. It is perfectly valid to receive an
> > > UDP packet with 0
> > Zero bytes is "end of file".  Don't go trying to co-opt end of file.
> > That way lies madness and despair.
> Please explain me what "end of file" means with UDP. If your UDP-based app
> expects to receive a zero when the other end stops transmitting, then it
> might wait for a very long time. As opposed to TCP, there's no FIN control
> flag to tell the remote host that you sent your last packet.

He means zero byte packet. :-)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

