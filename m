Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTKEKW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 05:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTKEKW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 05:22:57 -0500
Received: from pat.uio.no ([129.240.130.16]:58519 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262792AbTKEKWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 05:22:55 -0500
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: sfr@canb.auug.org.au
CC: linux-kernel@vger.kernel.org
In-reply-to: <20031105131509.23d38c58.sfr@canb.auug.org.au> (message from
	Stephen Rothwell on Wed, 5 Nov 2003 13:15:09 +1100)
Subject: Re: directory notification.
MIME-Version: 1.0
Message-Id: <E1AHKoL-0000xu-00@aqualene.uio.no>
Date: Wed, 5 Nov 2003 11:22:49 +0100
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Stephen Rothwell]
> On Tue, 4 Nov 2003 18:44:29 +0100 Terje Malmedal <terje.malmedal@usit.uio.no> wrote:
>> 
>> Modifications of existing files via NFS are not picked up by the
>> directory notification system.
>> 
>> kernel is 2.4.22, I'm testing with the example program from
>> /usr/src/linux/Documentation/dnotify.txt
>> 
>> I get notifications on the following: 
>> nfs-server# echo hello >> existing.file   
>> nfs-client# echo hello > new.file
>> 
>> But not on this: 
>> nfs-client# echo hello >> existing.file 
>> 
>> I guess the problem of detecting changes done via NFS is similar to
>> the problem of multiple hard-links to the same file, which is
>> documented as not supported.
>> 
>> Is this something that can be fixed, or is it going to be too
>> difficult to go from NFS-handle and back to the directory it came
>> from?

> Are you running the program that expects notifies on the NFS server or the
> client? 

On the server of course.

> If on the client, you will never get notifies for modifications
> made on the server or other clients.  If on the server, it needs looking
> at as you should get the notifies (I think - it has been a while since I
> last looked at the NFS server code).

It would be very nice if this could be fixed. 

-- 
 - Terje
malmedal@usit.uio.no
