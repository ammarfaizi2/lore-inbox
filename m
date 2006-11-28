Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757935AbWK1MYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757935AbWK1MYZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 07:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758250AbWK1MYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 07:24:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:9133 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1757935AbWK1MYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 07:24:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Wrd/eEZpjuMJWx0TccIJ95XWe9FEbpvxbqb2szWdfEJDPz7lZt87o+U1WTMLQPsRjx13tKPVluKJI8UmDQdZXXQG6QHA0JbaQnwzvp0QvkEidtROH+zd+mWosALztLhZsUNPdq7LIjXIFX7wtPTGx4nXGBwqiinx6kF0O+dZHgo=
Message-ID: <456C2A6F.9020406@gmail.com>
Date: Tue, 28 Nov 2006 21:24:15 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: avl@logic.at
CC: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Allow turning off hpa-checking.
References: <20061127130953.GA2352@gamma.logic.tuwien.ac.at> <20061127133044.28b8b4ed@localhost.localdomain> <20061127160144.GB2352@gamma.logic.tuwien.ac.at> <20061127163328.3f1c12eb@localhost.localdomain> <20061127175647.GD2352@gamma.logic.tuwien.ac.at> <20061127181033.58e72d9a@localhost.localdomain> <20061127182943.GE2352@gamma.logic.tuwien.ac.at> <20061127195940.1b90a897@localhost.localdomain> <20061128092930.GF2352@gamma.logic.tuwien.ac.at> <456C056D.2070008@gmail.com> <20061128120916.GG2352@gamma.logic.tuwien.ac.at>
In-Reply-To: <20061128120916.GG2352@gamma.logic.tuwien.ac.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Leitgeb wrote:
[--snip--]
> This theory is backed by my observation of a nearly-broken disk,
> that the quantity "3)" gradually goes down one step after some time.
> The first such step was, when I noticed the problem about half a
> year ago, and just recently it stepped down by another one.

Okay, if that happens on your drive, you gotta burn that foul thing and 
run away as fast/far away as you can.  ;-)

[--snip--]
> The point I'm really trying to make is, that there should be a
> boot option, to disable the query for "1)".  This *must* be a
> boot option, because the querying that I want to be able to
> prevent happens at boot time.
> My broken drive surely doesn't justify the option (or even this
> thread), but the third one of the "uses for 3)" mentioned above
> does. Once the native size is read, I no longer know how many
> sectors were previously "hidden away" by HPA, except by checking
> the kernel-log.
> 
> While Alan has already said, why he thought that this was the
> wrong approach, the reasoning was based on a misunderstanding
> of my question, which I here tried to clear up.

Dunno about IDE layer.  It has been done that way for long time and not 
sure whether adding such option will happen, but for libata, hpa 
handling is still not implemented and it will have to be optional when 
it gets implemented.  So, libata will have such option when it finally 
receives implementation for hpa handling.

-- 
tejun
