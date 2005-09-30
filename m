Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVI3GtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVI3GtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 02:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbVI3GtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 02:49:04 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:60942
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S932563AbVI3GtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 02:49:02 -0400
Date: Thu, 29 Sep 2005 23:35:10 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Prasenjit Sarkar <psarkar@almaden.ibm.com>
cc: ltuikov@yahoo.com, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       linux-scsi-owner@vger.kernel.org,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Linus Torvalds <torvalds@osdl.org>, Willy Tarreau <willy@w.ods.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
In-Reply-To: <OF914B6D62.B2BEC145-ON8825708B.0082FAA5-8825708B.00839885@us.ibm.com>
Message-ID: <Pine.LNX.4.10.10509292320240.27623-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Prasenjit,

The role of a standards body is to self promote and backslap each other
amd figure out how to divide the market and make money and not cause
problems.

The problem here is T10/T11 is the protocol is "ends justify the means".

This is where the clash of technical and design happens.

If the standards body was going to "primarily enforce interoperability",
then why the heck did the T10 proposal for "domain validation" become an
empty file and was withdrawn?  IIRC it was Adaptec who helped to kill
Domain Validation on T10, but I could be wrong and correction is warrented
here if needed.

"(iv) none of them come close to the T10 FSMs" is the answer, and this
justifies Linux's position to operate under "ends justify the means".

I can tell you why the T13 proposal died.  I killed when I withdrew it as
a direct result of T10's actions or lack of such.

As much as I believe in NCITS standards, they are worthless if no one is
there to assist in the process of creation, model, and adoption.

Regardless of anything stated above, the problem with creation of a scsi
standard core is most of the VOODOO of SCSI is hidden in the firmware.
James knows this fact and points it out on occassion.  SCSI is a FUZZY
State Machine and nowhere close to being consider finite.

Not sure if there is a good solution to date; however, James does have an
strong understanding of the mess and Christop is a good right hand
enforcer regardless that he and I disagree more often than agree.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Thu, 29 Sep 2005, Prasenjit Sarkar wrote:

> Luben,
> 
> The role of standard bodies is to primarily enforce interoperability but
> while they suggest FSMs and layering, those directives are not mandatory.
> 
> I have also seen industrial SCSI Core implementations from various sources
> to come to the following conclusions (i) they do not implement all the
> manadatory stuff (ii) they implement just enough to get by with
> interoperability [who has the time] (iii) any layering design is
> evolutionary and (iv) none of them come close to the T10 FSMs.
> 
> You may disagree, but there needs to be a balance between standards and
> implementations.
> 
> 
> 
> 
>                                                                            
>              Luben Tuikov                                                  
>              <ltuikov@yahoo.co                                             
>              m>                                                         To 
>              Sent by:                  Linus Torvalds <torvalds@osdl.org>, 
>              linux-scsi-owner@         Arjan van de Ven                    
>              vger.kernel.org           <arjan@infradead.org>               
>                                                                         cc 
>                                        Willy Tarreau <willy@w.ods.org>,    
>              09/29/2005 04:20          SCSI Mailing List                   
>              PM                        <linux-scsi@vger.kernel.org>,       
>                                        Andrew Morton <akpm@osdl.org>,      
>                                        Linux Kernel Mailing List           
>              Please respond to         <linux-kernel@vger.kernel.org>,     
>              ltuikov@yahoo.com         Luben Tuikov                        
>                                        <luben_tuikov@adaptec.com>, Jeff    
>                                        Garzik <jgarzik@pobox.com>          
>                                                                    Subject 
>                                        Re: I request inclusion of SAS      
>                                        Transport Layer and AIC-94xx into   
>                                        the kernel                          
>                                                                            
>                                                                            
>                                                                            
>                                                                            
>                                                                            
>                                                                            
> 
> 
> 
> 
> --- Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > A "spec" is close to useless. I have _never_ seen a spec that was both
> big
> > enough to be useful _and_ accurate.
> >
> > And I have seen _lots_ of total crap work that was based on specs. It's
> > _the_ single worst way to write software, because it by definition means
> > that the software was written to match theory, not reality.
> 
> A spec defines how a protocol works and behaves.  All SCSI specs
> are currently very layered and defined by FSMs.
> 
> This is _the reason_ I can plug in an Adaptec SAS host adapter
> to Vitesse Expander which has a Seagate SAS disk attached to phy X...
> And guess what? They interoperate and communicate with each other.
> 
> Why?  Because at each layer (physical/link/phy/etc) each
> one of them follow the FSMs defined in the, guess where, SAS spec.
> 
> If you take a SAS/SATA/FC/etc course, they _show you_ a link
> trace and then _show_ you how all of it is defined by the FSM
> specs, and make you follow the FSMs.
> 
> > So there's two MAJOR reasons to avoid specs:
> 
> Ok, then I accept that you and James Bottomley and Christoph are
> _right_, and I'm wrong.
> 
> I see we differ in ideology.
> 
> >    It's like real science: if you have a theory that doesn't match
> >    experiments, it doesn't matter _how_ much you like that theory. It's
> >    wrong. You can use it as an approximation, but you MUST keep in mind
> >    that it's an approximation.
> 
> But this is _the_ definition of a theory.  No one is arguing that
> a theory is not an approximation to observed behaviour.
> 
> What you have here is interoperability. Only possible because
> different vendors follow the same spec(s).
> 
> >  - specs have an inevitably tendency to try to introduce abstractions
> >    levels and wording and documentation policies that make sense for a
> >    written spec. Trying to implement actual code off the spec leads to
> the
> >    code looking and working like CRAP.
> 
> Ok, I give up: I'm wrong and you and James B are right.
> 
> >    The classic example of this is the OSI network model protocols.
> Classic
> 
> Yes, it is a _classic_ example and OSI is _very_ old.
> 
> _But_ the tendency of representing things in a _layered_, object oriented
> design has persisted.
> 
> >    spec-design, which had absolutely _zero_ relevance for the real world.
> 
> >    We still talk about the seven layers model, because it's a convenient
> >    model for _discussion_, but that has absolutely zero to do with any
> >    real-life software engineering. In other words, it's a way to _talk_
> >    about things, not to implement them.
> 
> Ok.
> 
> >    And that's important. Specs are a basis for _talking_about_ things.
> But
> >    they are _not_ a basis for implementing software.
> 
> Ok.  Let's forget about maintenance and adding _new_ functionality.
> 
> > So please don't bother talking about specs. Real standards grow up
> > _despite_ specs, not thanks to them.
> 
> Yes, you're right. Linus is always right.
> 
> Now to things more pertinent, which I'm sure people are interested in:
> 
> Jeff has been appointed to the role of integrating the SAS code
> with the Linux SCSI _model_, with James Bottomley's "transport attributes".
> So you can expect more patches from him.
> 
> Regards,
>     Luben
> 
> P.S. I have to get this 8139too.c network card here working.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

