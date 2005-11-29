Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVK2V5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVK2V5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 16:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVK2V5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 16:57:49 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:4628 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932439AbVK2V5s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 16:57:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BqXcwoDmVAK8zOjOofP0cFUARtYxUOc841lTzXOv2pe1xF0xeNbetGrHziPNpgS+DYURk1QRS5O1T0pM3zHKUd8I+7XfKLTTZ8a1XdvHYXGqlj1DFOYwr3tTohU7ZsR63InsAl+zXqHZglKh1QLw6tf15BTqEpe7WuAezJmGgTg=
Message-ID: <9611fa230511291357g3aa964adj6918fea50f5ee66e@mail.gmail.com>
Date: Tue, 29 Nov 2005 21:57:47 +0000
From: Tarkan Erimer <tarkane@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG]: Software compiling occasionlly hangs under 2.6.15-rc1/rc2 and 2.6.15-rc1-mm2
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051127165733.643d5444.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9611fa230511250312i55d0b872x82b8c33b4d2973e4@mail.gmail.com>
	 <1132917564.7068.41.camel@laptopd505.fenrus.org>
	 <9611fa230511270317led5b915h7daae3ef1287f86d@mail.gmail.com>
	 <1133092701.2853.0.camel@laptopd505.fenrus.org>
	 <9611fa230511271108m46389ee6w7ec6b5b40b1e23dd@mail.gmail.com>
	 <20051127165733.643d5444.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/05, Andrew Morton <akpm@osdl.org> wrote:
> XFS went nuts.  Please test the latest git snapshot which has fixes for
> this.

I tried 2.6.15-rc2-git6 and just released 2.6.15-rc3. Result is same.
I still got occasional hangs. When I check my syslog, I found no error
messages. But notice, XFS related errors have gone.  I paste last few
lines of my syslog.

----syslog ----
Nov 29 23:22:43 hightemple kernel: [  518.648894] NTFS-fs warning
(device hda1): ntfs_filldir(): Skipping unrepresentable inode 0x516d.
Nov 29 23:22:54 hightemple kernel: [  529.059660] printk: 36 messages
suppressed.
Nov 29 23:22:54 hightemple kernel: [  529.059669] NTFS-fs error
(device hda1): ntfs_ucstonls(): Unicode name contains characters that
cannot be converted to character set iso8859-1.  You might want to try
to use the mount option nls=utf8.
Nov 29 23:22:54 hightemple kernel: [  529.059676] NTFS-fs warning
(device hda1): ntfs_filldir(): Skipping unrepresentable inode 0x57db.
Nov 29 23:23:57 hightemple gconfd (root-11625): starting (version
2.12.1), pid 11625 user 'root'
Nov 29 23:23:57 hightemple gconfd (root-11625): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only
configuration source at position 0
Nov 29 23:23:57 hightemple gconfd (root-11625): Resolved address
"xml:readwrite:/root/.gconf" to a writable configuration source at
position 1
Nov 29 23:23:57 hightemple gconfd (root-11625): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only
configuration source at position 2
Nov 29 23:41:57 hightemple syslogd 1.4.1: restart.
----syslog----


Regards
