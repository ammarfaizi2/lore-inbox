Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136624AbREAOqh>; Tue, 1 May 2001 10:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136517AbREAOqS>; Tue, 1 May 2001 10:46:18 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:25678
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S135947AbREAOqF>; Tue, 1 May 2001 10:46:05 -0400
Message-Id: <200105011445.KAA01117@localhost.localdomain>
X-Mailer: exmh version 2.1.1 10/15/1999
To: "Roets, Chris" <Chris.Roets@compaq.com>
cc: "'James Bottomley'" <James.Bottomley@steeleye.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi 
In-Reply-To: Message from "Roets, Chris" <Chris.Roets@compaq.com> 
   of "Tue, 01 May 2001 14:07:11 BST." <6B180991CB19D31183E40000F86AF80E037EBD0E@broexc2.bro.dec.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 May 2001 10:45:00 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris.Roets@compaq.com said:
> So, will Linux ever support the scsi reservation mechanism as standard? 

That's not within my gift.  I can merely write the code that corrects the 
behaviour.  I can't force anyone else to accept it.

Chris.Roets@compaq.com said:
> Isn't there a standard that says if you scsi reserve a disk, no one
> else should be able to access this disk, or is this a "steeleye/
> Compaq" standard. 

Use of reservations is laid out in the SCSI-2 and SCSI-3 standards (which can 
be downloaded from the T10 site www.t10.org) which are international in scope. 
 I think the implementation issues come because the reservations part is 
really only relevant to a multi-initiator clustered environment which isn't an 
every day configuration for most Linux users.  Obviously, as Linux moves into 
the SAN arena this type of configuration will become a lot more common, at 
which time the various problems associated with multiple initiators should 
rise in prominence.

James


