Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284837AbRLKCoE>; Mon, 10 Dec 2001 21:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284849AbRLKCnz>; Mon, 10 Dec 2001 21:43:55 -0500
Received: from rj.SGI.COM ([204.94.215.100]:48585 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S284837AbRLKCnj>;
	Mon, 10 Dec 2001 21:43:39 -0500
Date: Tue, 11 Dec 2001 13:42:14 +1100
From: Nathan Scott <nathans@sgi.com>
To: Hans Reiser <reiser@namesys.com>, Andreas Gruenbacher <ag@bestbits.at>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: reiser4 (was Re: [PATCH] Revised extended attributes interface)
Message-ID: <20011211134213.G70201@wobbly.melbourne.sgi.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <3C127551.90305@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C127551.90305@namesys.com>; from reiser@namesys.com on Sat, Dec 08, 2001 at 11:17:21PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Hans,

On Sat, Dec 08, 2001 at 11:17:21PM +0300, Hans Reiser wrote:
> Nathan Scott wrote:
> >
> >In a way there's consensus wrt how to do POSIX ACLs on Linux
> >now, as both the ext2/ext3 and XFS ACL projects will be using
> >the same tools, libraries, etc.  In terms of other ACL types,
> >I don't know of anyone actively working on any.
> >
> We are taking a very different approach to EAs (and thus to ACLs) as 
> described in brief at www.namesys.com/v4/v4.html.  We don't expect 
> anyone to take us seriously on it before it works, but silence while 
> coding does not equal consensus.;-)
> 
> In essence, we think that if a file can't do what an EA can do, then you 
> need to make files able to do more.

We did read through your page awhile ago.  It wasn't clear to me
how you were addressing Anton's questions here:
http://marc.theaimsgroup.com/?l=linux-fsdevel&m=97260371413867&w=2
(I couldn't find a reply in the archive, but may have missed it).  

We were concentrating on something that could be fs-independent,
so the lack of answers there put us off a bit, and the dependence
on a reiser4() syscall is pretty filesystem-specific too (I guess
if your solution is intended to be a reiserfs-specific one, then
the questions above are meaningless).

I was curious on another thing also - in the section titled 
``The Usual Resolution Of These Flaws Is A One-Off Solution'',
talking about security attributes interfaces, your page says:

	"Linus said that we can have a system call to use as our
experimental plaything in this. With what I have in mind for the
API, one rather flexible system call is all we want..."

How did you manage to get him to say that?  We were flamed for
suggesting a syscall which multiplexed all extended attributes
commands though the one interface (because its semantics were
not clearly defined & it could be extended with new commands,
like ioctl/quotactl/...), and we've also had no luck so far in
getting either our original interface, nor any revised syscall
interfaces (which aren't like that anymore) accepted by Linus.

many thanks.

-- 
Nathan
