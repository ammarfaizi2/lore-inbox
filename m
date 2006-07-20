Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWGTRVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWGTRVP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 13:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWGTRVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 13:21:15 -0400
Received: from outmx018.isp.belgacom.be ([195.238.4.117]:63159 "EHLO
	outmx018.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750751AbWGTRVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 13:21:14 -0400
Subject: Re: [PATCH 2/2] Forgotten memset
From: Panagiotis Issaris <takis@gna.org>
To: "Daniel K." <daniel@cluded.net>
Cc: Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, linux-eata@i-connect.net
In-Reply-To: <44BD8FB7.9080307@cluded.net>
References: <20060719013407.GG30823@lumumba.uhasselt.be>
	 <44BD8FB7.9080307@cluded.net>
Content-Type: text/plain
Date: Thu, 20 Jul 2006 19:21:03 +0200
Message-Id: <1153416063.11873.15.camel@hemera>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On wo, 2006-07-19 at 01:49 +0000, Daniel K. wrote:
> Panagiotis Issaris wrote:
> > --- a/drivers/scsi/ide-scsi.c
> > +++ b/drivers/scsi/ide-scsi.c
> > @@ -327,7 +327,7 @@ static int idescsi_check_condition(ide_d
> >  
> >  	/* stuff a sense request in front of our current request */
> >  	pc = kzalloc (sizeof (idescsi_pc_t), GFP_ATOMIC);
> > -	rq = kmalloc (sizeof (struct request), GFP_ATOMIC);
> > +	rq = kzalloc (sizeof (struct request), GFP_ATOMIC);
> >  	buf = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_ATOMIC);
> >  	if (pc == NULL || rq == NULL || buf == NULL) {
> >  		kfree(buf);
> >
> > Was this forgotten and therefore, is it necessary or useful to zero this
> > out?
> 
> No, this code snippet is followed by a call to
> 
> 	ide_init_drive_cmd(rq)
> 
> which calls memset()
Ouch. I should have seen that. Thanks!

With friendly regards,
Takis


