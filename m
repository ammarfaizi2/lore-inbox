Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbULAKzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbULAKzC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 05:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbULAKzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 05:55:02 -0500
Received: from box.punkt.pl ([217.8.180.66]:46600 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261363AbULAKy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 05:54:58 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Wed, 1 Dec 2004 11:52:45 +0100
User-Agent: KMail/1.7
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <200412010008.13572.mmazur@kernel.pl> <20041201052328.GA8157@mars.ravnborg.org>
In-Reply-To: <20041201052328.GA8157@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200412011152.45279.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ¶roda 01 grudzieñ 2004 06:23, Sam Ravnborg wrote:
> > Linked, copied, mount --binded, whatever. Just not under the
> > name /usr/include/user, but something more meaningfull.
>
> Whats wrong with
> /lib/modules/`uname -r`/source/include/user
> /lib/modules/`uname -r`/source/include/$arch

Those are supposed to be userland-only headers that don't just change - they 
are gradually expanded. I don't see a point in having `uname -r` in there.

And another thing - distribution vendors will *hate* anyone, that encourages 
app developers to add an include path based on which kernel is being 
currently run. People, that have their headers tied to their kernels are a 
*minority*.

(though iirc eg. netfilter is a mess, so there might be bigger reasons to 
ignore my arguments; not that I won't hate you if you do, and I'll have to 
patch everything, just to get it compiled)

-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
