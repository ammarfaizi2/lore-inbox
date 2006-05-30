Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWE3UwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWE3UwN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWE3UwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:52:12 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:19685 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932353AbWE3UwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:52:11 -0400
Date: Tue, 30 May 2006 17:52:08 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060530175208.2c2dedaa@doriath.conectiva>
In-Reply-To: <20060530174821.GA15969@fks.be>
References: <20060529120102.1bc28bf2@doriath.conectiva>
	<20060529132553.08b225ba@doriath.conectiva>
	<20060529141110.6d149e21@doriath.conectiva>
	<20060529194334.GA32440@fks.be>
	<20060529172410.63dffa72@doriath.conectiva>
	<20060529204724.GA22250@fks.be>
	<20060529193330.3c51f3ba@home.brethil>
	<20060530082141.GA26517@fks.be>
	<20060530113801.22c71afe@doriath.conectiva>
	<20060530115329.30184aa0@doriath.conectiva>
	<20060530174821.GA15969@fks.be>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 19:48:21 +0200
Frank Gevaerts <frank.gevaerts@fks.be> wrote:

| On Tue, May 30, 2006 at 11:53:29AM -0300, Luiz Fernando N. Capitulino wrote:
| > On Tue, 30 May 2006 11:38:01 -0300
| > "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
| > 
| >  If it ran _before_ the timeout expires with no timeout error it does not
| > depend. Then we can do the simpler solution: just kill the read urb in the
| > ipaq_open's error path.
| 
| That seems to work.
| I also found that both the return in ipaq_write_bulk_callback and the
| flush_scheduled_work() in destroy_serial() are needed to get rid of the
| usb_serial_disconnect() bug.

 Then did you hit it with my patch?

 I'm just worried with the fact that you're hitting it with every
proposed fix. Maybe it's something else.

-- 
Luiz Fernando N. Capitulino
