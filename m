Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWE2UYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWE2UYP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 16:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWE2UYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 16:24:15 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:52453 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751278AbWE2UYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 16:24:14 -0400
Date: Mon, 29 May 2006 17:24:10 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Frank Gevaerts <frank.gevaerts@fks.be>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060529172410.63dffa72@doriath.conectiva>
In-Reply-To: <20060529194334.GA32440@fks.be>
References: <20060526182217.GA12687@fks.be>
	<20060526133410.9cfff805.zaitcev@redhat.com>
	<20060529120102.1bc28bf2@doriath.conectiva>
	<20060529132553.08b225ba@doriath.conectiva>
	<20060529141110.6d149e21@doriath.conectiva>
	<20060529194334.GA32440@fks.be>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 21:43:35 +0200
Frank Gevaerts <frank.gevaerts@fks.be> wrote:

| On Mon, May 29, 2006 at 02:11:10PM -0300, Luiz Fernando N. Capitulino wrote:
| > 
| >  Frank, could you try this one please?
| > 
| >  I have no sure whether this makes sense, but every USB-Serial driver
| > I know exits in the write URB callback if the URB got an error.
| 
| It looks sane to me at least.
| The machine is now running with this patch (and my ipaq_open patch, see
| http://www.ussg.iu.edu/hypermail/linux/kernel/0605.2/1901.html).

 Hmmm. Then does the workqueue problem began to happen _after_ you applied
your patch?

 Are you sure your patch is the right thing to do? Does it look reasonable
to submit that urb 1000 times that way?

 At first, it seems something else.

 Couldn't you run your test-case in a kernel previous to the TTY layer
buffering revamp change?

| If the problem is still there, it should occur within 24 hours in our
| usage mode (25 ipaqs rebooting every 15 minutes to provide lots of
| connects and disconnects).  I'll let you know the results.

 Wow, nice.

-- 
Luiz Fernando N. Capitulino
