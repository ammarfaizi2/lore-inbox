Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132580AbRDHR6x>; Sun, 8 Apr 2001 13:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132578AbRDHR6n>; Sun, 8 Apr 2001 13:58:43 -0400
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:16637 "HELO
	localdomain") by vger.kernel.org with SMTP id <S132576AbRDHR6c>;
	Sun, 8 Apr 2001 13:58:32 -0400
Message-ID: <XFMail.20010408110052.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200104081356.PAA24042@cave.bitwizard.nl>
Date: Sun, 08 Apr 2001 11:00:52 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: <R.E.Wolff@BitWizard.nl (Rogier Wolff)>
Subject: Re: goodbye
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>,
        Michael Peddemors <michael@linuxmagic.com>, kumon@flab.fujitsu.co.jp,
        Matti Aarnio <matti.aarnio@zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08-Apr-2001 Rogier Wolff wrote:
> Matti Aarnio wrote:
>> On Sun, Apr 08, 2001 at 02:10:52PM +0900, kumon@flab.fujitsu.co.jp wrote:
>> > How about creating an additional ML,
>> > the new ML (say LKML-DUL) is used to send mails from DUL to LKML, but
>> > such mails are not sent to LMKL.
>> 
>>      Layering and technology problem.
>> 
>>      SMTP receiver does those RBL/DUL/ORBS analysis, and its policy
>>      control does not know where exactly the email is heading into
>>      (that is, the reception policy is system level, not by recipients.)
> 
> Then fix it!
> 
> SMTP receivers should have the option of inserting a header line
> instead of blocking "bad" Emails. Then other layers can decide what to
> do with this Email.

I had the same problem of shifting down along the mail chain the knowledge of
the incoming IP address.
We develop VirusScreening and ContentFiltering MTA ( and appliances ) that
usually goes in front of customers MTA.
By putting our MTA in front of the customer MTAs chain We hide the peer IP
address to MTAs that comes next in the mail chain.
Our MTA uses a new ESMTP command :

XRMTIP remote-ip-address

to let customers MTA to know the remote IP address and let them to take all
relay and generic permissions decisions about the mail path.
We're going to distribute patches for most common MTAs like qmail, sendmail,
exim, XMail and postfix.
The patch rely on the presence of a file ( /etc/xrmtip.hosts ) that list the IPs
from which the XRMTIP command sould be accepted.



- Davide

