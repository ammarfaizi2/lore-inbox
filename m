Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVALViF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVALViF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVALVeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:34:10 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:27286 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261390AbVALVbz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:31:55 -0500
From: Vincenzo Ciancia <vincenzo_mlRE.MOVE@yahoo.it>
To: linux-kernel@vger.kernel.org
Subject: Re: [fuse-devel] Merging?
Date: Wed, 12 Jan 2005 22:33:58 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501122233.58450.vincenzo_mlRE.MOVE@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>>  Well, there doesn't seem to be a great rush to include FUSE in the
>>  kernel.  Maybe they just don't realize what they are missing out on ;)
> 
>heh.  What userspace filesystems have thus-far been developed, and what
> are people using them for?

There's been sort of an increasing hype around userspace filesystems 
during last years (and exponentially during last months), as a result 
we have lufs, plasticfs, fuse and some other implementation of a 
kernel-userspace bridge for filesystems, but also many more or less 
interesting (depending on one's point of view) ongoing free software 
projects using those, which mainly cover interfacing to "strange" or 
proprietary-protocol hardware devices as if they where filesystems, 
access to remote data as if it was local, or new filesystem concepts 
such as filesystems that have relational databases as helpers.

Apart from projects "officially" using fuse, listed at

http://fuse.sourceforge.net/filesystems.htm

I know of another interface to proprietary protocol mp3 players where 
they are actively developing a filesystem interface using fuse and 
libusb in ocaml - resulting in a quick and robust prototype written in 
a few spare time.

In defense of fuse itself I can mention the ease of use, both of the C
library and of interfaces for other languages, its robustness and its
completeness w.r.t. features (e.g. extended attributes, multithreading 
and access from multiple users and serving files "virtually" owned by 
different users).

Said this, and after commenting that I am nobody but yet another 
developer of yet another "new filesystem concept", I think that besides 
useful filesystems already developed, something good will come out of 
all these people experimenting with filesystems, databases, indexing 
systems and so on, but that if we want to take the good out of this 
all, even for already existing projects like sshfs or gphoto2-fuse-fs, 
we need fuse to be distributed in the kernel so that people is 
encouraged to try them in their everyday life. 

I will quote an e-mail from a researcher in a group who is implementing 
a particular filesystem and has ended up resorting to plasticfs (which 
uses the LD_PRELOAD trick - not quite satisfying but it does not 
require kernel patching) saying:

> Most of the problem I have [...] will still be in a better
> MLFUSE, which is that it requires to modify the kernel by loading a
> module (which is often tied to one particular version of Linux which
> means that it is tedious to maintain such module), and users hate
> that.

bye

Vincenzo Ciancia

ciancia at di unipi it
vincenzo_ml at yahoo it
