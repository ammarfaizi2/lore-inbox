Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289627AbSAOUAK>; Tue, 15 Jan 2002 15:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289629AbSAOUAC>; Tue, 15 Jan 2002 15:00:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55047 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289627AbSAOT7r>;
	Tue, 15 Jan 2002 14:59:47 -0500
Message-ID: <3C448A31.A08EBBF7@mandrakesoft.com>
Date: Tue, 15 Jan 2002 14:59:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Why not "attach" patches?
In-Reply-To: <E16QZFv-0005wy-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some implementation-specific details people may find useful:

* For 4.xx versions of Netscape Mail, with standard mime types/prefs,
sending patches by MIME attachment results in a readable text/plain
message.

* The best way to mail patches is to pipe a header, patch description,
and contents to "/usr/sbin/sendmail -t" or some other MTA.  When I spam
Linus or Marcelo with patches, my process looks like this:

1) create outgoing patches
2) change e-mail header template to reflect current kernel version
3) put template and blank space at top of each patch
4) "vi *.patch", manually insert descriptions and CC list from
MAINTAINERS
5) review each patch and description once again :)
6) pipe *.patch individually through "/usr/sbin/sendmail -t"

Here is the mail header template I use.  Sendmail is smart and will
insert all other headers like message-id and date, since they are not
present.  When using another MTA, make sure yours does this too.

> [jgarzik@rum g]$ cat ~/info/mail.linus
> From: Jeff Garzik <jgarzik at mandrakesoft.com>
> BCC: jgarzik at mandrakesoft.com
> To: Linus Torvalds <torvalds at transmeta.com>
> CC: akpm at zip.com.au, davem at redhat.com
> Subject: PATCH 2.5.2.9: net drvr 
> 

As always, read Documentation/SubmittingPatches.  That's what it's there
for.

-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
