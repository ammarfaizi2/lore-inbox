Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155492AbPGCCLD>; Fri, 2 Jul 1999 22:11:03 -0400
Received: by vger.rutgers.edu id <S155431AbPGCCKw>; Fri, 2 Jul 1999 22:10:52 -0400
Received: from jupiter.cs.uml.edu ([129.63.1.6]:3395 "EHLO jupiter.cs.uml.edu") by vger.rutgers.edu with ESMTP id <S155455AbPGCCKm>; Fri, 2 Jul 1999 22:10:42 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <199907030210.WAA26696@jupiter.cs.uml.edu>
Subject: Re: Mailbox
To: linux-kernel@vger.rutgers.edu
Date: Fri, 2 Jul 1999 22:10:41 -0400 (EDT)
X-Mailer: ELM [version 2.4 PL25]
Content-Type: text
Sender: owner-linux-kernel@vger.rutgers.edu

Keith Owens writes:
                                      
> Does any implementation exist for VMS mailbox ?

Nope.

> If not, wouldn't it be a good thing to patch kernel with such IPC ?

Maybe. It ought to be fun at least. It might help with NT compatibility.
If you need a file type, I've been collecting a list:

hex  name     ls octal  description
0000             000000 BSD unknown type (not used for inode)
1000 S_IFIFO  p| 010000 fifo (named pipe)
2000 S_IFCHR  c  020000 character special
3000 S_IFMPC     030000 multiplexed character device (Coherent)
4000 S_IFDIR  d/ 040000 directory
5000 S_IFNAM     050000 XENIX special named file
6000 S_IFBLK  b  060000 block special
7000 S_IFMPB     070000 multiplexed block device (Coherent)
8000 S_IFREG  -  110000 regular
9000 S_IFCMP     110000 VxFS compressed (file?)
a000 S_IFLNK  l@ 120000 symbolic link
b000 S_IFSHAD    130000 Solaris shadow inode for ACL
c000 S_IFSOCK s= 140000 socket (also "S_IFSOC" on VxFS)
d000 S_IFDOOR D  150000 Solaris door
e000 S_IFWHT   % 160000 BSD whiteout (not used for inode)
f000 S_IFMT      170000 mask (not used for inode)

I think you can steal S_IFMPC and S_IFMPB, along with either S_IFCMP
or S_IFSHAD. (since S_IFCMP and S_IFSHAD seem to be internal and do
not exist on the same filesystem, one can be mapped to the other)

I'd be interested in knowing more about S_IFNAM, the "available"
type codes, and anything missing from the table above. People with
S/390 Open Edition, NT, and OpenVMS might have interesting files.

Perhaps these values ought to go into kernel developer documentation.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
