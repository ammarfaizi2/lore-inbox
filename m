Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262655AbRFBSdo>; Sat, 2 Jun 2001 14:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262658AbRFBSde>; Sat, 2 Jun 2001 14:33:34 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:26121
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S262655AbRFBSda> convert rfc822-to-8bit; Sat, 2 Jun 2001 14:33:30 -0400
Date: Sat, 02 Jun 2001 14:33:19 -0400
From: Chris Mason <mason@suse.com>
To: Andreas Hartmann <andihartmann@freenet.de>
cc: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.5 and all ac-Patches] massive file corruption with reiser
 or NFS
Message-ID: <318710000.991506799@tiny>
In-Reply-To: <01060220134401.04097@athlon>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday, June 02, 2001 08:13:44 PM +0200 Andreas Hartmann
<andihartmann@freenet.de> wrote:

> Am Samstag,  2. Juni 2001 18:42 schrieben Sie:
>> On Saturday, June 02, 2001 02:41:04 PM +0200 Andreas Hartmann
>> >> <andihartmann@freenet.de> wrote:
>> > Am Samstag,  2. Juni 2001 12:52 schrieb Rasmus Bøg Hansen:
>> >> On Sat, 2 Jun 2001, Andreas Hartmann wrote:
>> >> > I got massive file corruptions with the kernels mentioned in the
>> >> > subject. I can reproduce it every time.
>> >> > >> >> >> You cannot use NFS on reiserfs unless you apply the knfsd patch.
>> >> >> Look at
>> >> >> >> www.namesys.com.
>> >> >> > > Thank you very much for your advice.
>> > > I tested your suggestion and run the machine without NFS-mounted
>> > > devices
>> > >> > - it  seems to be working fine. > > Anyway - I'm wondering why I didn't
>> > get any problem until 2.4.4ac10 with this  configuration without the
>> > appropriate patch on the client or on the server?
>> >> The problem only happens when the clients do an operation on a file that
>> has gone out of cache on the server.  Under light load, this might happen
>> very rarely.
> > The load didn't change. YOu can forget the load, it's very small. It's my 
> private server and I'm doing always the same thing via NFS - compiling
> e.g.  This has been working fine until 2.4.4.ac10, afterwards it has been
> broken.

Ok, there are two different problems here.  The patch you posted to l-k is
a generic NFS fix for 2.4.5.  ext2 would need this too.

If you are serving NFS from your reiserfs disk, you need an additional
patch on the server only (this is the one I was talking about).  Checkout
the FAQ on www.namesys.com for all the details.

-chris

