Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262302AbSJWAg0>; Tue, 22 Oct 2002 20:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262310AbSJWAg0>; Tue, 22 Oct 2002 20:36:26 -0400
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:60881 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S262302AbSJWAfz>; Tue, 22 Oct 2002 20:35:55 -0400
Date: Tue, 22 Oct 2002 20:34:20 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.44-ac1 : drivers/scsi/advansys.c
Message-ID: <Pine.LNX.4.44.0210222031460.913-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch removes an outdated macro STATIC. 
Regards,
Frank

--- linux/drivers/scsi/advansys.c.old	Sat Oct 19 12:05:42 2002
+++ linux/drivers/scsi/advansys.c	Tue Oct 22 19:32:13 2002
@@ -835,13 +835,6 @@
  * --- Debugging Header
  */
 
-#ifdef ADVANSYS_DEBUG
-#define STATIC
-#else /* ADVANSYS_DEBUG */
-#define STATIC static
-#endif /* ADVANSYS_DEBUG */
-
-
 /*
  * --- Asc Library Constants and Macros
  */
@@ -2003,119 +1996,119 @@
 #define AscReadChipDvcID(port)            (uchar)inp((port)+IOP_REG_ID)
 #define AscWriteChipDvcID(port, data)     outp((port)+IOP_REG_ID, data)
 
-STATIC int       AscWriteEEPCmdReg(PortAddr iop_base, uchar cmd_reg);
-STATIC int       AscWriteEEPDataReg(PortAddr iop_base, ushort data_reg);
-STATIC void      AscWaitEEPRead(void);
-STATIC void      AscWaitEEPWrite(void);
-STATIC ushort    AscReadEEPWord(PortAddr, uchar);
-STATIC ushort    AscWriteEEPWord(PortAddr, uchar, ushort);
-STATIC ushort    AscGetEEPConfig(PortAddr, ASCEEP_CONFIG *, ushort);
-STATIC int       AscSetEEPConfigOnce(PortAddr, ASCEEP_CONFIG *, ushort);
-STATIC int       AscSetEEPConfig(PortAddr, ASCEEP_CONFIG *, ushort);
-STATIC int       AscStartChip(PortAddr);
-STATIC int       AscStopChip(PortAddr);
-STATIC void      AscSetChipIH(PortAddr, ushort);
-STATIC int       AscIsChipHalted(PortAddr);
-STATIC void      AscAckInterrupt(PortAddr);
-STATIC void      AscDisableInterrupt(PortAddr);
-STATIC void      AscEnableInterrupt(PortAddr);
-STATIC void      AscSetBank(PortAddr, uchar);
-STATIC int       AscResetChipAndScsiBus(ASC_DVC_VAR *);
+static int       AscWriteEEPCmdReg(PortAddr iop_base, uchar cmd_reg);
+static int       AscWriteEEPDataReg(PortAddr iop_base, ushort data_reg);
+static void      AscWaitEEPRead(void);
+static void      AscWaitEEPWrite(void);
+static ushort    AscReadEEPWord(PortAddr, uchar);
+static ushort    AscWriteEEPWord(PortAddr, uchar, ushort);
+static ushort    AscGetEEPConfig(PortAddr, ASCEEP_CONFIG *, ushort);
+static int       AscSetEEPConfigOnce(PortAddr, ASCEEP_CONFIG *, ushort);
+static int       AscSetEEPConfig(PortAddr, ASCEEP_CONFIG *, ushort);
+static int       AscStartChip(PortAddr);
+static int       AscStopChip(PortAddr);
+static void      AscSetChipIH(PortAddr, ushort);
+static int       AscIsChipHalted(PortAddr);
+static void      AscAckInterrupt(PortAddr);
+static void      AscDisableInterrupt(PortAddr);
+static void      AscEnableInterrupt(PortAddr);
+static void      AscSetBank(PortAddr, uchar);
+static int       AscResetChipAndScsiBus(ASC_DVC_VAR *);
 #ifdef CONFIG_ISA
-STATIC ushort    AscGetIsaDmaChannel(PortAddr);
-STATIC ushort    AscSetIsaDmaChannel(PortAddr, ushort);
-STATIC uchar     AscSetIsaDmaSpeed(PortAddr, uchar);
-STATIC uchar     AscGetIsaDmaSpeed(PortAddr);
+static ushort    AscGetIsaDmaChannel(PortAddr);
+static ushort    AscSetIsaDmaChannel(PortAddr, ushort);
+static uchar     AscSetIsaDmaSpeed(PortAddr, uchar);
+static uchar     AscGetIsaDmaSpeed(PortAddr);
 #endif /* CONFIG_ISA */
-STATIC uchar     AscReadLramByte(PortAddr, ushort);
-STATIC ushort    AscReadLramWord(PortAddr, ushort);
+static uchar     AscReadLramByte(PortAddr, ushort);
+static ushort    AscReadLramWord(PortAddr, ushort);
 #if CC_VERY_LONG_SG_LIST
-STATIC ASC_DCNT  AscReadLramDWord(PortAddr, ushort);
+static ASC_DCNT  AscReadLramDWord(PortAddr, ushort);
 #endif /* CC_VERY_LONG_SG_LIST */
-STATIC void      AscWriteLramWord(PortAddr, ushort, ushort);
-STATIC void      AscWriteLramByte(PortAddr, ushort, uchar);
-STATIC ASC_DCNT  AscMemSumLramWord(PortAddr, ushort, int);
-STATIC void      AscMemWordSetLram(PortAddr, ushort, ushort, int);
-STATIC void      AscMemWordCopyPtrToLram(PortAddr, ushort, uchar *, int);
-STATIC void      AscMemDWordCopyPtrToLram(PortAddr, ushort, uchar *, int);
-STATIC void      AscMemWordCopyPtrFromLram(PortAddr, ushort, uchar *, int);
-STATIC ushort    AscInitAscDvcVar(ASC_DVC_VAR *);
-STATIC ushort    AscInitFromEEP(ASC_DVC_VAR *);
-STATIC ushort    AscInitFromAscDvcVar(ASC_DVC_VAR *);
-STATIC ushort    AscInitMicroCodeVar(ASC_DVC_VAR *);
-STATIC int       AscTestExternalLram(ASC_DVC_VAR *);
-STATIC uchar     AscMsgOutSDTR(ASC_DVC_VAR *, uchar, uchar);
-STATIC uchar     AscCalSDTRData(ASC_DVC_VAR *, uchar, uchar);
-STATIC void      AscSetChipSDTR(PortAddr, uchar, uchar);
-STATIC uchar     AscGetSynPeriodIndex(ASC_DVC_VAR *, uchar);
-STATIC uchar     AscAllocFreeQueue(PortAddr, uchar);
-STATIC uchar     AscAllocMultipleFreeQueue(PortAddr, uchar, uchar);
-STATIC int       AscHostReqRiscHalt(PortAddr);
-STATIC int       AscStopQueueExe(PortAddr);
-STATIC int       AscSendScsiQueue(ASC_DVC_VAR *,
+static void      AscWriteLramWord(PortAddr, ushort, ushort);
+static void      AscWriteLramByte(PortAddr, ushort, uchar);
+static ASC_DCNT  AscMemSumLramWord(PortAddr, ushort, int);
+static void      AscMemWordSetLram(PortAddr, ushort, ushort, int);
+static void      AscMemWordCopyPtrToLram(PortAddr, ushort, uchar *, int);
+static void      AscMemDWordCopyPtrToLram(PortAddr, ushort, uchar *, int);
+static void      AscMemWordCopyPtrFromLram(PortAddr, ushort, uchar *, int);
+static ushort    AscInitAscDvcVar(ASC_DVC_VAR *);
+static ushort    AscInitFromEEP(ASC_DVC_VAR *);
+static ushort    AscInitFromAscDvcVar(ASC_DVC_VAR *);
+static ushort    AscInitMicroCodeVar(ASC_DVC_VAR *);
+static int       AscTestExternalLram(ASC_DVC_VAR *);
+static uchar     AscMsgOutSDTR(ASC_DVC_VAR *, uchar, uchar);
+static uchar     AscCalSDTRData(ASC_DVC_VAR *, uchar, uchar);
+static void      AscSetChipSDTR(PortAddr, uchar, uchar);
+static uchar     AscGetSynPeriodIndex(ASC_DVC_VAR *, uchar);
+static uchar     AscAllocFreeQueue(PortAddr, uchar);
+static uchar     AscAllocMultipleFreeQueue(PortAddr, uchar, uchar);
+static int       AscHostReqRiscHalt(PortAddr);
+static int       AscStopQueueExe(PortAddr);
+static int       AscSendScsiQueue(ASC_DVC_VAR *,
                     ASC_SCSI_Q * scsiq,
                     uchar n_q_required);
-STATIC int       AscPutReadyQueue(ASC_DVC_VAR *,
+static int       AscPutReadyQueue(ASC_DVC_VAR *,
                     ASC_SCSI_Q *, uchar);
-STATIC int       AscPutReadySgListQueue(ASC_DVC_VAR *,
+static int       AscPutReadySgListQueue(ASC_DVC_VAR *,
                     ASC_SCSI_Q *, uchar);
-STATIC int       AscSetChipSynRegAtID(PortAddr, uchar, uchar);
-STATIC int       AscSetRunChipSynRegAtID(PortAddr, uchar, uchar);
-STATIC ushort    AscInitLram(ASC_DVC_VAR *);
-STATIC ushort    AscInitQLinkVar(ASC_DVC_VAR *);
-STATIC int       AscSetLibErrorCode(ASC_DVC_VAR *, ushort);
-STATIC int       AscIsrChipHalted(ASC_DVC_VAR *);
-STATIC uchar     _AscCopyLramScsiDoneQ(PortAddr, ushort,
+static int       AscSetChipSynRegAtID(PortAddr, uchar, uchar);
+static int       AscSetRunChipSynRegAtID(PortAddr, uchar, uchar);
+static ushort    AscInitLram(ASC_DVC_VAR *);
+static ushort    AscInitQLinkVar(ASC_DVC_VAR *);
+static int       AscSetLibErrorCode(ASC_DVC_VAR *, ushort);
+static int       AscIsrChipHalted(ASC_DVC_VAR *);
+static uchar     _AscCopyLramScsiDoneQ(PortAddr, ushort,
                     ASC_QDONE_INFO *, ASC_DCNT);
-STATIC int       AscIsrQDone(ASC_DVC_VAR *);
-STATIC int       AscCompareString(uchar *, uchar *, int);
+static int       AscIsrQDone(ASC_DVC_VAR *);
+static int       AscCompareString(uchar *, uchar *, int);
 #ifdef CONFIG_ISA
-STATIC ushort    AscGetEisaChipCfg(PortAddr);
-STATIC ASC_DCNT  AscGetEisaProductID(PortAddr);
-STATIC PortAddr  AscSearchIOPortAddrEISA(PortAddr);
-STATIC PortAddr  AscSearchIOPortAddr11(PortAddr);
-STATIC PortAddr  AscSearchIOPortAddr(PortAddr, ushort);
-STATIC void      AscSetISAPNPWaitForKey(void);
+static ushort    AscGetEisaChipCfg(PortAddr);
+static ASC_DCNT  AscGetEisaProductID(PortAddr);
+static PortAddr  AscSearchIOPortAddrEISA(PortAddr);
+static PortAddr  AscSearchIOPortAddr11(PortAddr);
+static PortAddr  AscSearchIOPortAddr(PortAddr, ushort);
+static void      AscSetISAPNPWaitForKey(void);
 #endif /* CONFIG_ISA */
-STATIC uchar     AscGetChipScsiCtrl(PortAddr);
-STATIC uchar     AscSetChipScsiID(PortAddr, uchar);
-STATIC uchar     AscGetChipVersion(PortAddr, ushort);
-STATIC ushort    AscGetChipBusType(PortAddr);
-STATIC ASC_DCNT  AscLoadMicroCode(PortAddr, ushort, uchar *, ushort);
-STATIC int       AscFindSignature(PortAddr);
-STATIC void      AscToggleIRQAct(PortAddr);
-STATIC uchar     AscGetChipIRQ(PortAddr, ushort);
-STATIC uchar     AscSetChipIRQ(PortAddr, uchar, ushort);
-STATIC ushort    AscGetChipBiosAddress(PortAddr, ushort);
-STATIC inline ulong DvcEnterCritical(void);
-STATIC inline void DvcLeaveCritical(ulong);
+static uchar     AscGetChipScsiCtrl(PortAddr);
+static uchar     AscSetChipScsiID(PortAddr, uchar);
+static uchar     AscGetChipVersion(PortAddr, ushort);
+static ushort    AscGetChipBusType(PortAddr);
+static ASC_DCNT  AscLoadMicroCode(PortAddr, ushort, uchar *, ushort);
+static int       AscFindSignature(PortAddr);
+static void      AscToggleIRQAct(PortAddr);
+static uchar     AscGetChipIRQ(PortAddr, ushort);
+static uchar     AscSetChipIRQ(PortAddr, uchar, ushort);
+static ushort    AscGetChipBiosAddress(PortAddr, ushort);
+static inline ulong DvcEnterCritical(void);
+static inline void DvcLeaveCritical(ulong);
 #ifdef CONFIG_PCI
-STATIC uchar     DvcReadPCIConfigByte(ASC_DVC_VAR *, ushort);
-STATIC void      DvcWritePCIConfigByte(ASC_DVC_VAR *,
+static uchar     DvcReadPCIConfigByte(ASC_DVC_VAR *, ushort);
+static void      DvcWritePCIConfigByte(ASC_DVC_VAR *,
                     ushort, uchar);
 #endif /* CONFIG_PCI */
-STATIC ushort      AscGetChipBiosAddress(PortAddr, ushort);
-STATIC void      DvcSleepMilliSecond(ASC_DCNT);
-STATIC void      DvcDelayNanoSecond(ASC_DVC_VAR *, ASC_DCNT);
-STATIC void      DvcPutScsiQ(PortAddr, ushort, uchar *, int);
-STATIC void      DvcGetQinfo(PortAddr, ushort, uchar *, int);
-STATIC ushort    AscInitGetConfig(ASC_DVC_VAR *);
-STATIC ushort    AscInitSetConfig(ASC_DVC_VAR *);
-STATIC ushort    AscInitAsc1000Driver(ASC_DVC_VAR *);
-STATIC void      AscAsyncFix(ASC_DVC_VAR *, uchar,
+static ushort      AscGetChipBiosAddress(PortAddr, ushort);
+static void      DvcSleepMilliSecond(ASC_DCNT);
+static void      DvcDelayNanoSecond(ASC_DVC_VAR *, ASC_DCNT);
+static void      DvcPutScsiQ(PortAddr, ushort, uchar *, int);
+static void      DvcGetQinfo(PortAddr, ushort, uchar *, int);
+static ushort    AscInitGetConfig(ASC_DVC_VAR *);
+static ushort    AscInitSetConfig(ASC_DVC_VAR *);
+static ushort    AscInitAsc1000Driver(ASC_DVC_VAR *);
+static void      AscAsyncFix(ASC_DVC_VAR *, uchar,
                     ASC_SCSI_INQUIRY *);
-STATIC int       AscTagQueuingSafe(ASC_SCSI_INQUIRY *);
-STATIC void      AscInquiryHandling(ASC_DVC_VAR *,
+static int       AscTagQueuingSafe(ASC_SCSI_INQUIRY *);
+static void      AscInquiryHandling(ASC_DVC_VAR *,
                     uchar, ASC_SCSI_INQUIRY *);
-STATIC int       AscExeScsiQueue(ASC_DVC_VAR *, ASC_SCSI_Q *);
-STATIC int       AscISR(ASC_DVC_VAR *);
-STATIC uint      AscGetNumOfFreeQueue(ASC_DVC_VAR *, uchar,
+static int       AscExeScsiQueue(ASC_DVC_VAR *, ASC_SCSI_Q *);
+static int       AscISR(ASC_DVC_VAR *);
+static uint      AscGetNumOfFreeQueue(ASC_DVC_VAR *, uchar,
                     uchar);
-STATIC int       AscSgListToQueue(int);
+static int       AscSgListToQueue(int);
 #ifdef CONFIG_ISA
-STATIC void      AscEnableIsaDma(uchar);
+static void      AscEnableIsaDma(uchar);
 #endif /* CONFIG_ISA */
-STATIC ASC_DCNT  AscGetMaxDmaCount(ushort);
+static ASC_DCNT  AscGetMaxDmaCount(ushort);
 
 
 /*
@@ -3247,43 +3240,43 @@
 /*
  * Device drivers must define the following functions.
  */
-STATIC inline ulong DvcEnterCritical(void);
-STATIC inline void  DvcLeaveCritical(ulong);
-STATIC void  DvcSleepMilliSecond(ADV_DCNT);
-STATIC uchar DvcAdvReadPCIConfigByte(ADV_DVC_VAR *, ushort);
-STATIC void  DvcAdvWritePCIConfigByte(ADV_DVC_VAR *, ushort, uchar);
-STATIC ADV_PADDR DvcGetPhyAddr(ADV_DVC_VAR *, ADV_SCSI_REQ_Q *,
+static inline ulong DvcEnterCritical(void);
+static inline void  DvcLeaveCritical(ulong);
+static void  DvcSleepMilliSecond(ADV_DCNT);
+static uchar DvcAdvReadPCIConfigByte(ADV_DVC_VAR *, ushort);
+static void  DvcAdvWritePCIConfigByte(ADV_DVC_VAR *, ushort, uchar);
+static ADV_PADDR DvcGetPhyAddr(ADV_DVC_VAR *, ADV_SCSI_REQ_Q *,
                 uchar *, ASC_SDCNT *, int);
-STATIC void  DvcDelayMicroSecond(ADV_DVC_VAR *, ushort);
+static void  DvcDelayMicroSecond(ADV_DVC_VAR *, ushort);
 
 /*
  * Adv Library functions available to drivers.
  */
-STATIC int     AdvExeScsiQueue(ADV_DVC_VAR *, ADV_SCSI_REQ_Q *);
-STATIC int     AdvISR(ADV_DVC_VAR *);
-STATIC int     AdvInitGetConfig(ADV_DVC_VAR *);
-STATIC int     AdvInitAsc3550Driver(ADV_DVC_VAR *);
-STATIC int     AdvInitAsc38C0800Driver(ADV_DVC_VAR *);
-STATIC int     AdvInitAsc38C1600Driver(ADV_DVC_VAR *);
-STATIC int     AdvResetChipAndSB(ADV_DVC_VAR *);
-STATIC int     AdvResetSB(ADV_DVC_VAR *asc_dvc);
+static int     AdvExeScsiQueue(ADV_DVC_VAR *, ADV_SCSI_REQ_Q *);
+static int     AdvISR(ADV_DVC_VAR *);
+static int     AdvInitGetConfig(ADV_DVC_VAR *);
+static int     AdvInitAsc3550Driver(ADV_DVC_VAR *);
+static int     AdvInitAsc38C0800Driver(ADV_DVC_VAR *);
+static int     AdvInitAsc38C1600Driver(ADV_DVC_VAR *);
+static int     AdvResetChipAndSB(ADV_DVC_VAR *);
+static int     AdvResetSB(ADV_DVC_VAR *asc_dvc);
 
 /*
  * Internal Adv Library functions.
  */
-STATIC int    AdvSendIdleCmd(ADV_DVC_VAR *, ushort, ADV_DCNT);
-STATIC void   AdvInquiryHandling(ADV_DVC_VAR *, ADV_SCSI_REQ_Q *);
-STATIC int    AdvInitFrom3550EEP(ADV_DVC_VAR *);
-STATIC int    AdvInitFrom38C0800EEP(ADV_DVC_VAR *);
-STATIC int    AdvInitFrom38C1600EEP(ADV_DVC_VAR *);
-STATIC ushort AdvGet3550EEPConfig(AdvPortAddr, ADVEEP_3550_CONFIG *);
-STATIC void   AdvSet3550EEPConfig(AdvPortAddr, ADVEEP_3550_CONFIG *);
-STATIC ushort AdvGet38C0800EEPConfig(AdvPortAddr, ADVEEP_38C0800_CONFIG *);
-STATIC void   AdvSet38C0800EEPConfig(AdvPortAddr, ADVEEP_38C0800_CONFIG *);
-STATIC ushort AdvGet38C1600EEPConfig(AdvPortAddr, ADVEEP_38C1600_CONFIG *);
-STATIC void   AdvSet38C1600EEPConfig(AdvPortAddr, ADVEEP_38C1600_CONFIG *);
-STATIC void   AdvWaitEEPCmd(AdvPortAddr);
-STATIC ushort AdvReadEEPWord(AdvPortAddr, int);
+static int    AdvSendIdleCmd(ADV_DVC_VAR *, ushort, ADV_DCNT);
+static void   AdvInquiryHandling(ADV_DVC_VAR *, ADV_SCSI_REQ_Q *);
+static int    AdvInitFrom3550EEP(ADV_DVC_VAR *);
+static int    AdvInitFrom38C0800EEP(ADV_DVC_VAR *);
+static int    AdvInitFrom38C1600EEP(ADV_DVC_VAR *);
+static ushort AdvGet3550EEPConfig(AdvPortAddr, ADVEEP_3550_CONFIG *);
+static void   AdvSet3550EEPConfig(AdvPortAddr, ADVEEP_3550_CONFIG *);
+static ushort AdvGet38C0800EEPConfig(AdvPortAddr, ADVEEP_38C0800_CONFIG *);
+static void   AdvSet38C0800EEPConfig(AdvPortAddr, ADVEEP_38C0800_CONFIG *);
+static ushort AdvGet38C1600EEPConfig(AdvPortAddr, ADVEEP_38C1600_CONFIG *);
+static void   AdvSet38C1600EEPConfig(AdvPortAddr, ADVEEP_38C1600_CONFIG *);
+static void   AdvWaitEEPCmd(AdvPortAddr);
+static ushort AdvReadEEPWord(AdvPortAddr, int);
 
 /*
  * PCI Bus Definitions
@@ -4162,20 +4155,20 @@
 #endif /* ASC_LINUX_KERNEL22 */
 
 /* Number of boards detected in system. */
-STATIC int asc_board_count = 0;
-STATIC struct Scsi_Host    *asc_host[ASC_NUM_BOARD_SUPPORTED] = { 0 };
+static int asc_board_count = 0;
+static struct Scsi_Host    *asc_host[ASC_NUM_BOARD_SUPPORTED] = { 0 };
 
 /* Overrun buffer used by all narrow boards. */
-STATIC uchar overrun_buf[ASC_OVERRUN_BSIZE] = { 0 };
+static uchar overrun_buf[ASC_OVERRUN_BSIZE] = { 0 };
 
 /*
  * Global structures required to issue a command.
  */
-STATIC ASC_SCSI_Q asc_scsi_q = { { 0 } };
-STATIC ASC_SG_HEAD asc_sg_head = { 0 };
+static ASC_SCSI_Q asc_scsi_q = { { 0 } };
+static ASC_SG_HEAD asc_sg_head = { 0 };
 
 /* List of supported bus types. */
-STATIC ushort asc_bus[ASC_NUM_BUS] ASC_INITDATA = {
+static ushort asc_bus[ASC_NUM_BUS] ASC_INITDATA = {
     ASC_IS_ISA,
     ASC_IS_VL,
     ASC_IS_EISA,
@@ -4186,11 +4179,11 @@
  * Used with the LILO 'advansys' option to eliminate or
  * limit I/O port probing at boot time, cf. advansys_setup().
  */
-STATIC int asc_iopflag = ASC_FALSE;
-STATIC int asc_ioport[ASC_NUM_IOPORT_PROBE] = { 0, 0, 0, 0 };
+static int asc_iopflag = ASC_FALSE;
+static int asc_ioport[ASC_NUM_IOPORT_PROBE] = { 0, 0, 0, 0 };
 
 #ifdef ADVANSYS_DEBUG
-STATIC char *
+static char *
 asc_bus_name[ASC_NUM_BUS] = {
     "ASC_IS_ISA",
     "ASC_IS_VL",
@@ -4198,11 +4191,11 @@
     "ASC_IS_PCI",
 };
 
-STATIC int          asc_dbglvl = 3;
+static int          asc_dbglvl = 3;
 #endif /* ADVANSYS_DEBUG */
 
 /* Declaration for Asc Library internal data referenced by driver. */
-STATIC PortAddr     _asc_def_iop_base[];
+static PortAddr     _asc_def_iop_base[];
 
 
 /*
@@ -4211,59 +4204,59 @@
  * advansys.h contains function prototypes for functions global to Linux.
  */
 
-STATIC void       advansys_interrupt(int, void *, struct pt_regs *);
-STATIC int	  advansys_slave_attach(Scsi_Device *);
-STATIC void       asc_scsi_done_list(Scsi_Cmnd *, int from_isr);
-STATIC int        asc_execute_scsi_cmnd(Scsi_Cmnd *);
-STATIC int        asc_build_req(asc_board_t *, Scsi_Cmnd *);
-STATIC int        adv_build_req(asc_board_t *, Scsi_Cmnd *, ADV_SCSI_REQ_Q **);
-STATIC int        adv_get_sglist(asc_board_t *, adv_req_t *, Scsi_Cmnd *);
-STATIC void       asc_isr_callback(ASC_DVC_VAR *, ASC_QDONE_INFO *);
-STATIC void       adv_isr_callback(ADV_DVC_VAR *, ADV_SCSI_REQ_Q *);
-STATIC void       adv_async_callback(ADV_DVC_VAR *, uchar);
-STATIC void       asc_enqueue(asc_queue_t *, REQP, int);
-STATIC REQP       asc_dequeue(asc_queue_t *, int);
-STATIC REQP       asc_dequeue_list(asc_queue_t *, REQP *, int);
-STATIC int        asc_rmqueue(asc_queue_t *, REQP);
-STATIC void       asc_execute_queue(asc_queue_t *);
+static void       advansys_interrupt(int, void *, struct pt_regs *);
+static int	  advansys_slave_attach(Scsi_Device *);
+static void       asc_scsi_done_list(Scsi_Cmnd *, int from_isr);
+static int        asc_execute_scsi_cmnd(Scsi_Cmnd *);
+static int        asc_build_req(asc_board_t *, Scsi_Cmnd *);
+static int        adv_build_req(asc_board_t *, Scsi_Cmnd *, ADV_SCSI_REQ_Q **);
+static int        adv_get_sglist(asc_board_t *, adv_req_t *, Scsi_Cmnd *);
+static void       asc_isr_callback(ASC_DVC_VAR *, ASC_QDONE_INFO *);
+static void       adv_isr_callback(ADV_DVC_VAR *, ADV_SCSI_REQ_Q *);
+static void       adv_async_callback(ADV_DVC_VAR *, uchar);
+static void       asc_enqueue(asc_queue_t *, REQP, int);
+static REQP       asc_dequeue(asc_queue_t *, int);
+static REQP       asc_dequeue_list(asc_queue_t *, REQP *, int);
+static int        asc_rmqueue(asc_queue_t *, REQP);
+static void       asc_execute_queue(asc_queue_t *);
 #ifdef CONFIG_PROC_FS
-STATIC int        asc_proc_copy(off_t, off_t, char *, int , char *, int);
-STATIC int        asc_prt_board_devices(struct Scsi_Host *, char *, int);
-STATIC int        asc_prt_adv_bios(struct Scsi_Host *, char *, int);
-STATIC int        asc_get_eeprom_string(ushort *serialnum, uchar *cp);
-STATIC int        asc_prt_asc_board_eeprom(struct Scsi_Host *, char *, int);
-STATIC int        asc_prt_adv_board_eeprom(struct Scsi_Host *, char *, int);
-STATIC int        asc_prt_driver_conf(struct Scsi_Host *, char *, int);
-STATIC int        asc_prt_asc_board_info(struct Scsi_Host *, char *, int);
-STATIC int        asc_prt_adv_board_info(struct Scsi_Host *, char *, int);
-STATIC int        asc_prt_line(char *, int, char *fmt, ...);
+static int        asc_proc_copy(off_t, off_t, char *, int , char *, int);
+static int        asc_prt_board_devices(struct Scsi_Host *, char *, int);
+static int        asc_prt_adv_bios(struct Scsi_Host *, char *, int);
+static int        asc_get_eeprom_string(ushort *serialnum, uchar *cp);
+static int        asc_prt_asc_board_eeprom(struct Scsi_Host *, char *, int);
+static int        asc_prt_adv_board_eeprom(struct Scsi_Host *, char *, int);
+static int        asc_prt_driver_conf(struct Scsi_Host *, char *, int);
+static int        asc_prt_asc_board_info(struct Scsi_Host *, char *, int);
+static int        asc_prt_adv_board_info(struct Scsi_Host *, char *, int);
+static int        asc_prt_line(char *, int, char *fmt, ...);
 #endif /* CONFIG_PROC_FS */
 
 /* Declaration for Asc Library internal functions referenced by driver. */
-STATIC int          AscFindSignature(PortAddr);
-STATIC ushort       AscGetEEPConfig(PortAddr, ASCEEP_CONFIG *, ushort);
+static int          AscFindSignature(PortAddr);
+static ushort       AscGetEEPConfig(PortAddr, ASCEEP_CONFIG *, ushort);
 
 /* Statistics function prototypes. */
 #ifdef ADVANSYS_STATS
 #ifdef CONFIG_PROC_FS
-STATIC int          asc_prt_board_stats(struct Scsi_Host *, char *, int);
-STATIC int          asc_prt_target_stats(struct Scsi_Host *, int, char *, int);
+static int          asc_prt_board_stats(struct Scsi_Host *, char *, int);
+static int          asc_prt_target_stats(struct Scsi_Host *, int, char *, int);
 #endif /* CONFIG_PROC_FS */
 #endif /* ADVANSYS_STATS */
 
 /* Debug function prototypes. */
 #ifdef ADVANSYS_DEBUG
-STATIC void         asc_prt_scsi_host(struct Scsi_Host *);
-STATIC void         asc_prt_scsi_cmnd(Scsi_Cmnd *);
-STATIC void         asc_prt_asc_dvc_cfg(ASC_DVC_CFG *);
-STATIC void         asc_prt_asc_dvc_var(ASC_DVC_VAR *);
-STATIC void         asc_prt_asc_scsi_q(ASC_SCSI_Q *);
-STATIC void         asc_prt_asc_qdone_info(ASC_QDONE_INFO *);
-STATIC void         asc_prt_adv_dvc_cfg(ADV_DVC_CFG *);
-STATIC void         asc_prt_adv_dvc_var(ADV_DVC_VAR *);
-STATIC void         asc_prt_adv_scsi_req_q(ADV_SCSI_REQ_Q *);
-STATIC void         asc_prt_adv_sgblock(int, ADV_SG_BLOCK *);
-STATIC void         asc_prt_hex(char *f, uchar *, int);
+static void         asc_prt_scsi_host(struct Scsi_Host *);
+static void         asc_prt_scsi_cmnd(Scsi_Cmnd *);
+static void         asc_prt_asc_dvc_cfg(ASC_DVC_CFG *);
+static void         asc_prt_asc_dvc_var(ASC_DVC_VAR *);
+static void         asc_prt_asc_scsi_q(ASC_SCSI_Q *);
+static void         asc_prt_asc_qdone_info(ASC_QDONE_INFO *);
+static void         asc_prt_adv_dvc_cfg(ADV_DVC_CFG *);
+static void         asc_prt_adv_dvc_var(ADV_DVC_VAR *);
+static void         asc_prt_adv_scsi_req_q(ADV_SCSI_REQ_Q *);
+static void         asc_prt_adv_sgblock(int, ADV_SG_BLOCK *);
+static void         asc_prt_hex(char *f, uchar *, int);
 #endif /* ADVANSYS_DEBUG */
 
 
@@ -6250,7 +6243,7 @@
  * to the AdvanSys driver which is for a device sharing an interrupt with
  * an AdvanSys adapter.
  */
-STATIC void
+static void
 advansys_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
     ulong           flags;
@@ -6347,7 +6340,7 @@
  * Set the number of commands to queue per device for the
  * specified host adapter.
  */
-STATIC int
+static int
 advansys_slave_attach(Scsi_Device *device)
 {
     asc_board_t        *boardp;
@@ -6382,7 +6375,7 @@
  *
  * Interrupts can be enabled on entry.
  */
-STATIC void
+static void
 asc_scsi_done_list(Scsi_Cmnd *scp, int from_isr)
 {
     Scsi_Cmnd    *tscp;
@@ -6452,7 +6445,7 @@
  * If ASC_BUSY is returned the request will be enqueued by the
  * caller on the target's waiting queue and re-tried later.
  */
-STATIC int
+static int
 asc_execute_scsi_cmnd(Scsi_Cmnd *scp)
 {
     asc_board_t        *boardp;
@@ -6625,7 +6618,7 @@
  * If an error occurs, then queue the request on the board done
  * queue and return ASC_ERROR.
  */
-STATIC int
+static int
 asc_build_req(asc_board_t *boardp, Scsi_Cmnd *scp)
 {
     /*
@@ -6756,7 +6749,7 @@
  * microcode for DMA addresses or math operations are byte swapped
  * to little-endian order.
  */
-STATIC int
+static int
 adv_build_req(asc_board_t *boardp, Scsi_Cmnd *scp,
     ADV_SCSI_REQ_Q **adv_scsiqpp)
 {
@@ -6906,7 +6899,7 @@
  *      ADV_SUCCESS(1) - SG List successfully created
  *      ADV_ERROR(-1) - SG List creation failed
  */
-STATIC int
+static int
 adv_get_sglist(asc_board_t *boardp, adv_req_t *reqp, Scsi_Cmnd *scp)
 {
     adv_sgblk_t         *sgblkp;
@@ -7017,7 +7010,7 @@
  *
  * Interrupt callback function for the Narrow SCSI Asc Library.
  */
-STATIC void
+static void
 asc_isr_callback(ASC_DVC_VAR *asc_dvc_varp, ASC_QDONE_INFO *qdonep)
 {
     asc_board_t         *boardp;
@@ -7185,7 +7178,7 @@
  *
  * Callback function for the Wide SCSI Adv Library.
  */
-STATIC void
+static void
 adv_isr_callback(ADV_DVC_VAR *adv_dvc_varp, ADV_SCSI_REQ_Q *scsiqp)
 {
     asc_board_t         *boardp;
@@ -7388,7 +7381,7 @@
 /*
  * adv_async_callback() - Adv Library asynchronous event callback function.
  */
-STATIC void
+static void
 adv_async_callback(ADV_DVC_VAR *adv_dvc_varp, uchar code)
 {
     switch (code)
@@ -7431,7 +7424,7 @@
  *
  * 'REQPNEXT(reqp)' returns reqp's next pointer.
  */
-STATIC void
+static void
 asc_enqueue(asc_queue_t *ascq, REQP reqp, int flag)
 {
     int        tid;
@@ -7484,7 +7477,7 @@
  *
  * 'REQPNEXT(reqp)' returns reqp's next pointer.
  */
-STATIC REQP
+static REQP
 asc_dequeue(asc_queue_t *ascq, int tid)
 {
     REQP    reqp;
@@ -7531,7 +7524,7 @@
  * Unfortunately collecting queuing time statistics adds overhead to
  * the function that isn't inherent to the function's algorithm.
  */
-STATIC REQP
+static REQP
 asc_dequeue_list(asc_queue_t *ascq, REQP *lastpp, int tid)
 {
     REQP    firstp, lastp;
@@ -7611,7 +7604,7 @@
  * Return ASC_TRUE if the command was found and removed,
  * otherwise return ASC_FALSE.
  */
-STATIC int
+static int
 asc_rmqueue(asc_queue_t *ascq, REQP reqp)
 {
     REQP        currp, prevp;
@@ -7679,7 +7672,7 @@
  *
  * Calls asc_execute_scsi_cmnd() to execute a REQP/Scsi_Cmnd.
  */
-STATIC void
+static void
 asc_execute_queue(asc_queue_t *ascq)
 {
     ADV_SCSI_BIT_ID_TYPE    scan_tidmask;
@@ -7724,7 +7717,7 @@
  * Return the number of characters copied into 'cp'. No more than
  * 'cplen' characters will be copied to 'cp'.
  */
-STATIC int
+static int
 asc_prt_board_devices(struct Scsi_Host *shp, char *cp, int cplen)
 {
     asc_board_t        *boardp;
@@ -7765,7 +7758,7 @@
 /*
  * Display Wide Board BIOS Information.
  */
-STATIC int
+static int
 asc_prt_adv_bios(struct Scsi_Host *shp, char *cp, int cplen)
 {
     asc_board_t        *boardp;
@@ -7845,7 +7838,7 @@
  *
  * Returns ASC_TRUE if serial number found, otherwise returns ASC_FALSE.
  */
-STATIC int
+static int
 asc_get_eeprom_string(ushort *serialnum, uchar *cp)
 {
     ushort      w, num;
@@ -7932,7 +7925,7 @@
  * Return the number of characters copied into 'cp'. No more than
  * 'cplen' characters will be copied to 'cp'.
  */
-STATIC int
+static int
 asc_prt_asc_board_eeprom(struct Scsi_Host *shp, char *cp, int cplen)
 {
     asc_board_t        *boardp;
@@ -8061,7 +8054,7 @@
  * Return the number of characters copied into 'cp'. No more than
  * 'cplen' characters will be copied to 'cp'.
  */
-STATIC int
+static int
 asc_prt_adv_board_eeprom(struct Scsi_Host *shp, char *cp, int cplen)
 {
     asc_board_t                 *boardp;
@@ -8366,7 +8359,7 @@
  * Return the number of characters copied into 'cp'. No more than
  * 'cplen' characters will be copied to 'cp'.
  */
-STATIC int
+static int
 asc_prt_driver_conf(struct Scsi_Host *shp, char *cp, int cplen)
 {
     asc_board_t            *boardp;
@@ -8453,7 +8446,7 @@
  * Return the number of characters copied into 'cp'. No more than
  * 'cplen' characters will be copied to 'cp'.
  */
-STATIC int
+static int
 asc_prt_asc_board_info(struct Scsi_Host *shp, char *cp, int cplen)
 {
     asc_board_t            *boardp;
@@ -8638,7 +8631,7 @@
  * Return the number of characters copied into 'cp'. No more than
  * 'cplen' characters will be copied to 'cp'.
  */
-STATIC int
+static int
 asc_prt_adv_board_info(struct Scsi_Host *shp, char *cp, int cplen)
 {
     asc_board_t            *boardp;
@@ -8877,7 +8870,7 @@
  * Copy proc information to a read buffer taking into account the current
  * read offset in the file and the remaining space in the read buffer.
  */
-STATIC int
+static int
 asc_proc_copy(off_t advoffset, off_t offset, char *curbuf, int leftlen,
               char *cp, int cplen)
 {
@@ -8914,7 +8907,7 @@
  * Note: If any single line is greater than ASC_PRTLINE_SIZE bytes the stack
  * will be corrupted. 's[]' is defined to be ASC_PRTLINE_SIZE bytes.
  */
-STATIC int
+static int
 asc_prt_line(char *buf, int buflen, char *fmt, ...)
 {
     va_list        args;
@@ -8947,7 +8940,7 @@
  * from a timer interrupt, because this function may be
  * called when interrupts are disabled.
  */
-STATIC void
+static void
 DvcSleepMilliSecond(ADV_DCNT n)
 {
     ASC_DBG1(4, "DvcSleepMilliSecond: %lu\n", (ulong) n);
@@ -8958,7 +8951,7 @@
  * Currently and inline noop but leave as a placeholder.
  * Leave DvcEnterCritical() as a noop placeholder.
  */
-STATIC inline ulong
+static inline ulong
 DvcEnterCritical(void)
 {
     return 0;
@@ -8968,7 +8961,7 @@
  * Critical sections are all protected by the board spinlock.
  * Leave DvcLeaveCritical() as a noop placeholder.
  */
-STATIC inline void
+static inline void
 DvcLeaveCritical(ulong flags)
 {
     return;
@@ -8984,7 +8977,7 @@
  * Description:
  *     Output an ASC_SCSI_Q structure to the chip
  */
-STATIC void
+static void
 DvcPutScsiQ(PortAddr iop_base, ushort s_addr, uchar *outbuf, int words)
 {
     int    i;
@@ -9010,7 +9003,7 @@
  * Description:
  *     Input an ASC_QDONE_INFO structure from the chip
  */
-STATIC void
+static void
 DvcGetQinfo(PortAddr iop_base, ushort s_addr, uchar *inbuf, int words)
 {
     int    i;
@@ -9032,7 +9025,7 @@
  * Read a PCI configuration byte.
  */
 ASC_INITFUNC(
-STATIC uchar,
+static uchar,
 DvcReadPCIConfigByte(
         ASC_DVC_VAR *asc_dvc,
         ushort offset)
@@ -9054,7 +9047,7 @@
  * Write a PCI configuration byte.
  */
 ASC_INITFUNC(
-STATIC void,
+static void,
 DvcWritePCIConfigByte(
         ASC_DVC_VAR *asc_dvc,
         ushort offset,
@@ -9074,7 +9067,7 @@
  * I/O port and with the specified bus type.
  */
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AscGetChipBiosAddress(
         PortAddr iop_base,
         ushort bus_type
@@ -9155,7 +9148,7 @@
  * Read a PCI configuration byte.
  */
 ASC_INITFUNC(
-STATIC uchar,
+static uchar,
 DvcAdvReadPCIConfigByte(
         ADV_DVC_VAR *asc_dvc,
         ushort offset)
@@ -9177,7 +9170,7 @@
  * Write a PCI configuration byte.
  */
 ASC_INITFUNC(
-STATIC void,
+static void,
 DvcAdvWritePCIConfigByte(
         ADV_DVC_VAR *asc_dvc,
         ushort offset,
@@ -9209,7 +9202,7 @@
  * Return the number of characters copied into 'cp'. No more than
  * 'cplen' characters will be copied to 'cp'.
  */
-STATIC int
+static int
 asc_prt_board_stats(struct Scsi_Host *shp, char *cp, int cplen)
 {
     int                    leftlen;
@@ -9314,7 +9307,7 @@
  * Return the number of characters copied into 'cp'. No more than
  * 'cplen' characters will be copied to 'cp'.
  */
-STATIC int
+static int
 asc_prt_target_stats(struct Scsi_Host *shp, int tgt_id, char *cp, int cplen)
 {
     int                    leftlen;
@@ -9386,7 +9379,7 @@
 /*
  * asc_prt_scsi_host()
  */
-STATIC void
+static void
 asc_prt_scsi_host(struct Scsi_Host *s)
 {
     asc_board_t         *boardp;
@@ -9433,7 +9426,7 @@
 /*
  * asc_prt_scsi_cmnd()
  */
-STATIC void
+static void
 asc_prt_scsi_cmnd(Scsi_Cmnd *s)
 {
     printk("Scsi_Cmnd at addr 0x%lx\n", (ulong) s);
@@ -9487,7 +9480,7 @@
 /*
  * asc_prt_asc_dvc_var()
  */
-STATIC void
+static void
 asc_prt_asc_dvc_var(ASC_DVC_VAR *h)
 {
     printk("ASC_DVC_VAR at addr 0x%lx\n", (ulong) h);
@@ -9529,7 +9522,7 @@
 /*
  * asc_prt_asc_dvc_cfg()
  */
-STATIC void
+static void
 asc_prt_asc_dvc_cfg(ASC_DVC_CFG *h)
 {
     printk("ASC_DVC_CFG at addr 0x%lx\n", (ulong) h);
@@ -9558,7 +9551,7 @@
 /*
  * asc_prt_asc_scsi_q()
  */
-STATIC void
+static void
 asc_prt_asc_scsi_q(ASC_SCSI_Q *q)
 {
     ASC_SG_HEAD    *sgp;
@@ -9598,7 +9591,7 @@
 /*
  * asc_prt_asc_qdone_info()
  */
-STATIC void
+static void
 asc_prt_asc_qdone_info(ASC_QDONE_INFO *q)
 {
     printk("ASC_QDONE_INFO at addr 0x%lx\n", (ulong) q);
@@ -9616,7 +9609,7 @@
  *
  * Display an ADV_DVC_VAR structure.
  */
-STATIC void
+static void
 asc_prt_adv_dvc_var(ADV_DVC_VAR *h)
 {
     printk(" ADV_DVC_VAR at addr 0x%lx\n", (ulong) h);
@@ -9658,7 +9651,7 @@
  *
  * Display an ADV_DVC_CFG structure.
  */
-STATIC void
+static void
 asc_prt_adv_dvc_cfg(ADV_DVC_CFG *h)
 {
     printk(" ADV_DVC_CFG at addr 0x%lx\n", (ulong) h);
@@ -9685,7 +9678,7 @@
  *
  * Display an ADV_SCSI_REQ_Q structure.
  */
-STATIC void
+static void
 asc_prt_adv_scsi_req_q(ADV_SCSI_REQ_Q *q)
 {
     int                 sg_blk_cnt;
@@ -9746,7 +9739,7 @@
  *
  * Display an ADV_SG_BLOCK structure.
  */
-STATIC void
+static void
 asc_prt_adv_sgblock(int sgblockno, ADV_SG_BLOCK *b)
 {
     int i;
@@ -9772,7 +9765,7 @@
  * Print hexadecimal output in 4 byte groupings 32 bytes
  * or 8 double-words per line.
  */
-STATIC void
+static void
 asc_prt_hex(char *f, uchar *s, int l)
 {
     int            i;
@@ -9829,7 +9822,7 @@
  */
 
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AscGetEisaChipCfg(
                      PortAddr iop_base
 )
@@ -9843,7 +9836,7 @@
 }
 
 ASC_INITFUNC(
-STATIC uchar,
+static uchar,
 AscSetChipScsiID(
                     PortAddr iop_base,
                     uchar new_host_id
@@ -9863,7 +9856,7 @@
 }
 
 ASC_INITFUNC(
-STATIC uchar,
+static uchar,
 AscGetChipScsiCtrl(
                       PortAddr iop_base
 )
@@ -9878,7 +9871,7 @@
 }
 
 ASC_INITFUNC(
-STATIC uchar,
+static uchar,
 AscGetChipVersion(
                      PortAddr iop_base,
                      ushort bus_type
@@ -9897,7 +9890,7 @@
 }
 
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AscGetChipBusType(
                      PortAddr iop_base
 )
@@ -9931,7 +9924,7 @@
     return (0);
 }
 
-STATIC ASC_DCNT
+static ASC_DCNT
 AscLoadMicroCode(
                     PortAddr iop_base,
                     ushort s_addr,
@@ -9960,7 +9953,7 @@
     return (chksum);
 }
 
-STATIC int
+static int
 AscFindSignature(
                     PortAddr iop_base
 )
@@ -9981,17 +9974,17 @@
     return (0);
 }
 
-STATIC PortAddr _asc_def_iop_base[ASC_IOADR_TABLE_MAX_IX] ASC_INITDATA =
+static PortAddr _asc_def_iop_base[ASC_IOADR_TABLE_MAX_IX] ASC_INITDATA =
 {
     0x100, ASC_IOADR_1, 0x120, ASC_IOADR_2, 0x140, ASC_IOADR_3, ASC_IOADR_4,
     ASC_IOADR_5, ASC_IOADR_6, ASC_IOADR_7, ASC_IOADR_8
 };
 
 #ifdef CONFIG_ISA
-STATIC uchar _isa_pnp_inited ASC_INITDATA = 0;
+static uchar _isa_pnp_inited ASC_INITDATA = 0;
 
 ASC_INITFUNC(
-STATIC PortAddr,
+static PortAddr,
 AscSearchIOPortAddr(
                        PortAddr iop_beg,
                        ushort bus_type
@@ -10028,7 +10021,7 @@
 }
 
 ASC_INITFUNC(
-STATIC PortAddr,
+static PortAddr,
 AscSearchIOPortAddr11(
                          PortAddr s_addr
 )
@@ -10059,7 +10052,7 @@
 }
 
 ASC_INITFUNC(
-STATIC void,
+static void,
 AscSetISAPNPWaitForKey(
     void)
 )
@@ -10071,7 +10064,7 @@
 #endif /* CONFIG_ISA */
 
 ASC_INITFUNC(
-STATIC void,
+static void,
 AscToggleIRQAct(
                    PortAddr iop_base
 )
@@ -10083,7 +10076,7 @@
 }
 
 ASC_INITFUNC(
-STATIC uchar,
+static uchar,
 AscGetChipIRQ(
                  PortAddr iop_base,
                  ushort bus_type
@@ -10119,7 +10112,7 @@
 }
 
 ASC_INITFUNC(
-STATIC uchar,
+static uchar,
 AscSetChipIRQ(
                  PortAddr iop_base,
                  uchar irq_no,
@@ -10161,7 +10154,7 @@
 
 #ifdef CONFIG_ISA
 ASC_INITFUNC(
-STATIC void,
+static void,
 AscEnableIsaDma(
                    uchar dma_channel
 )
@@ -10178,7 +10171,7 @@
 }
 #endif /* CONFIG_ISA */
 
-STATIC int
+static int
 AscIsrChipHalted(
                     ASC_DVC_VAR *asc_dvc
 )
@@ -10612,7 +10605,7 @@
     return (0);
 }
 
-STATIC uchar
+static uchar
 _AscCopyLramScsiDoneQ(
                          PortAddr iop_base,
                          ushort q_addr,
@@ -10656,7 +10649,7 @@
     return (sg_queue_cnt);
 }
 
-STATIC int
+static int
 AscIsrQDone(
                ASC_DVC_VAR *asc_dvc
 )
@@ -10793,7 +10786,7 @@
     return (0);
 }
 
-STATIC int
+static int
 AscISR(
           ASC_DVC_VAR *asc_dvc
 )
@@ -10892,7 +10885,7 @@
 }
 
 /* Microcode buffer is kept after initialization for error recovery. */
-STATIC uchar _asc_mcode_buf[] =
+static uchar _asc_mcode_buf[] =
 {
   0x01,  0x03,  0x01,  0x19,  0x0F,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,
   0x0F,  0x0F,  0x0F,  0x0F,  0x0F,  0x0F,  0x0F,  0x0F,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,
@@ -11040,11 +11033,11 @@
   0xF1,  0xC7,  0x41,  0x23,  0xF8,  0x88,  0x11,  0x23,  0xA1,  0x01,  0x04,  0x23,  0xA0,  0x01,  0xE6,  0x84,
 };
 
-STATIC ushort _asc_mcode_size = sizeof(_asc_mcode_buf);
-STATIC ADV_DCNT _asc_mcode_chksum = 0x012C453FUL;
+static ushort _asc_mcode_size = sizeof(_asc_mcode_buf);
+static ADV_DCNT _asc_mcode_chksum = 0x012C453FUL;
 
 #define ASC_SYN_OFFSET_ONE_DISABLE_LIST  16
-STATIC uchar _syn_offset_one_disable_cmd[ASC_SYN_OFFSET_ONE_DISABLE_LIST] =
+static uchar _syn_offset_one_disable_cmd[ASC_SYN_OFFSET_ONE_DISABLE_LIST] =
 {
     SCSICMD_Inquiry,
     SCSICMD_RequestSense,
@@ -11064,7 +11057,7 @@
     0xFF
 };
 
-STATIC int
+static int
 AscExeScsiQueue(
                    ASC_DVC_VAR *asc_dvc,
                    ASC_SCSI_Q *scsiq
@@ -11272,7 +11265,7 @@
     return (sta);
 }
 
-STATIC int
+static int
 AscSendScsiQueue(
                     ASC_DVC_VAR *asc_dvc,
                     ASC_SCSI_Q *scsiq,
@@ -11322,7 +11315,7 @@
     return (sta);
 }
 
-STATIC int
+static int
 AscSgListToQueue(
                     int sg_list
 )
@@ -11336,7 +11329,7 @@
 }
 
 
-STATIC uint
+static uint
 AscGetNumOfFreeQueue(
                         ASC_DVC_VAR *asc_dvc,
                         uchar target_ix,
@@ -11378,7 +11371,7 @@
     return (0);
 }
 
-STATIC int
+static int
 AscPutReadyQueue(
                     ASC_DVC_VAR *asc_dvc,
                     ASC_SCSI_Q *scsiq,
@@ -11424,7 +11417,7 @@
     return (1);
 }
 
-STATIC int
+static int
 AscPutReadySgListQueue(
                           ASC_DVC_VAR *asc_dvc,
                           ASC_SCSI_Q *scsiq,
@@ -11556,7 +11549,7 @@
     return (sta);
 }
 
-STATIC int
+static int
 AscSetRunChipSynRegAtID(
                            PortAddr iop_base,
                            uchar tid_no,
@@ -11573,7 +11566,7 @@
     return (sta);
 }
 
-STATIC int
+static int
 AscSetChipSynRegAtID(
                         PortAddr iop_base,
                         uchar id,
@@ -11607,7 +11600,7 @@
     return (sta);
 }
 
-STATIC ushort
+static ushort
 AscInitLram(
                ASC_DVC_VAR *asc_dvc
 )
@@ -11660,7 +11653,7 @@
     return (warn_code);
 }
 
-STATIC ushort
+static ushort
 AscInitQLinkVar(
                    ASC_DVC_VAR *asc_dvc
 )
@@ -11693,7 +11686,7 @@
     return (0);
 }
 
-STATIC int
+static int
 AscSetLibErrorCode(
                       ASC_DVC_VAR *asc_dvc,
                       ushort err_code
@@ -11708,7 +11701,7 @@
 }
 
 
-STATIC uchar
+static uchar
 AscMsgOutSDTR(
                  ASC_DVC_VAR *asc_dvc,
                  uchar sdtr_period,
@@ -11745,7 +11738,7 @@
     }
 }
 
-STATIC uchar
+static uchar
 AscCalSDTRData(
                   ASC_DVC_VAR *asc_dvc,
                   uchar sdtr_period,
@@ -11765,7 +11758,7 @@
     return (byte);
 }
 
-STATIC void
+static void
 AscSetChipSDTR(
                   PortAddr iop_base,
                   uchar sdtr_data,
@@ -11777,7 +11770,7 @@
     return;
 }
 
-STATIC uchar
+static uchar
 AscGetSynPeriodIndex(
                         ASC_DVC_VAR *asc_dvc,
                         uchar syn_time
@@ -11803,7 +11796,7 @@
     }
 }
 
-STATIC uchar
+static uchar
 AscAllocFreeQueue(
                      PortAddr iop_base,
                      uchar free_q_head
@@ -11824,7 +11817,7 @@
     return (ASC_QLINK_END);
 }
 
-STATIC uchar
+static uchar
 AscAllocMultipleFreeQueue(
                              PortAddr iop_base,
                              uchar free_q_head,
@@ -11842,7 +11835,7 @@
     return (free_q_head);
 }
 
-STATIC int
+static int
 AscHostReqRiscHalt(
                       PortAddr iop_base
 )
@@ -11868,7 +11861,7 @@
     return (sta);
 }
 
-STATIC int
+static int
 AscStopQueueExe(
                    PortAddr iop_base
 )
@@ -11890,13 +11883,13 @@
     return (0);
 }
 
-STATIC void
+static void
 DvcDelayMicroSecond(ADV_DVC_VAR *asc_dvc, ushort micro_sec)
 {
     udelay(micro_sec);
 }
 
-STATIC void
+static void
 DvcDelayNanoSecond(ASC_DVC_VAR *asc_dvc, ASC_DCNT nano_sec)
 {
     udelay((nano_sec + 999)/1000);
@@ -11904,7 +11897,7 @@
 
 #ifdef CONFIG_ISA
 ASC_INITFUNC(
-STATIC ASC_DCNT,
+static ASC_DCNT,
 AscGetEisaProductID(
                        PortAddr iop_base
 )
@@ -11923,7 +11916,7 @@
 }
 
 ASC_INITFUNC(
-STATIC PortAddr,
+static PortAddr,
 AscSearchIOPortAddrEISA(
                            PortAddr iop_base
 )
@@ -11963,7 +11956,7 @@
 }
 #endif /* CONFIG_ISA */
 
-STATIC int
+static int
 AscStartChip(
                 PortAddr iop_base
 )
@@ -11975,7 +11968,7 @@
     return (1);
 }
 
-STATIC int
+static int
 AscStopChip(
                PortAddr iop_base
 )
@@ -11992,7 +11985,7 @@
     return (1);
 }
 
-STATIC int
+static int
 AscIsChipHalted(
                    PortAddr iop_base
 )
@@ -12005,7 +11998,7 @@
     return (0);
 }
 
-STATIC void
+static void
 AscSetChipIH(
                 PortAddr iop_base,
                 ushort ins_code
@@ -12017,7 +12010,7 @@
     return;
 }
 
-STATIC void
+static void
 AscAckInterrupt(
                    PortAddr iop_base
 )
@@ -12048,7 +12041,7 @@
     return;
 }
 
-STATIC void
+static void
 AscDisableInterrupt(
                        PortAddr iop_base
 )
@@ -12060,7 +12053,7 @@
     return;
 }
 
-STATIC void
+static void
 AscEnableInterrupt(
                       PortAddr iop_base
 )
@@ -12074,7 +12067,7 @@
 
 
 
-STATIC void
+static void
 AscSetBank(
               PortAddr iop_base,
               uchar bank
@@ -12095,7 +12088,7 @@
     return;
 }
 
-STATIC int
+static int
 AscResetChipAndScsiBus(
                           ASC_DVC_VAR *asc_dvc
 )
@@ -12122,7 +12115,7 @@
 }
 
 ASC_INITFUNC(
-STATIC ASC_DCNT,
+static ASC_DCNT,
 AscGetMaxDmaCount(
                      ushort bus_type
 )
@@ -12137,7 +12130,7 @@
 
 #ifdef CONFIG_ISA
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AscGetIsaDmaChannel(
                        PortAddr iop_base
 )
@@ -12154,7 +12147,7 @@
 }
 
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AscSetIsaDmaChannel(
                        PortAddr iop_base,
                        ushort dma_channel
@@ -12178,7 +12171,7 @@
 }
 
 ASC_INITFUNC(
-STATIC uchar,
+static uchar,
 AscSetIsaDmaSpeed(
                      PortAddr iop_base,
                      uchar speed_value
@@ -12193,7 +12186,7 @@
 }
 
 ASC_INITFUNC(
-STATIC uchar,
+static uchar,
 AscGetIsaDmaSpeed(
                      PortAddr iop_base
 )
@@ -12210,7 +12203,7 @@
 #endif /* CONFIG_ISA */
 
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AscReadPCIConfigWord(
     ASC_DVC_VAR *asc_dvc,
     ushort pci_config_offset)
@@ -12224,7 +12217,7 @@
 }
 
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AscInitGetConfig(
         ASC_DVC_VAR *asc_dvc
 )
@@ -12309,7 +12302,7 @@
 }
 
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AscInitSetConfig(
                     ASC_DVC_VAR *asc_dvc
 )
@@ -12330,7 +12323,7 @@
 }
 
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AscInitFromAscDvcVar(
                         ASC_DVC_VAR *asc_dvc
 )
@@ -12394,7 +12387,7 @@
     return (warn_code);
 }
 
-STATIC ushort
+static ushort
 AscInitAsc1000Driver(
                         ASC_DVC_VAR *asc_dvc
 )
@@ -12435,7 +12428,7 @@
 }
 
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AscInitAscDvcVar(
                     ASC_DVC_VAR *asc_dvc
 )
@@ -12550,7 +12543,7 @@
 }
 
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AscInitFromEEP(
                   ASC_DVC_VAR *asc_dvc
 )
@@ -12718,7 +12711,7 @@
     return (warn_code);
 }
 
-STATIC ushort
+static ushort
 AscInitMicroCodeVar(
                        ASC_DVC_VAR *asc_dvc
 )
@@ -12771,7 +12764,7 @@
 }
 
 ASC_INITFUNC(
-STATIC int,
+static int,
 AscTestExternalLram(
                        ASC_DVC_VAR *asc_dvc
 )
@@ -12798,7 +12791,7 @@
 }
 
 ASC_INITFUNC(
-STATIC int,
+static int,
 AscWriteEEPCmdReg(
                      PortAddr iop_base,
                      uchar cmd_reg
@@ -12823,7 +12816,7 @@
 }
 
 ASC_INITFUNC(
-STATIC int,
+static int,
 AscWriteEEPDataReg(
                       PortAddr iop_base,
                       ushort data_reg
@@ -12848,7 +12841,7 @@
 }
 
 ASC_INITFUNC(
-STATIC void,
+static void,
 AscWaitEEPRead(
                   void
 )
@@ -12859,7 +12852,7 @@
 }
 
 ASC_INITFUNC(
-STATIC void,
+static void,
 AscWaitEEPWrite(
                    void
 )
@@ -12870,7 +12863,7 @@
 }
 
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AscReadEEPWord(
                   PortAddr iop_base,
                   uchar addr
@@ -12891,7 +12884,7 @@
 }
 
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AscWriteEEPWord(
                    PortAddr iop_base,
                    uchar addr,
@@ -12918,7 +12911,7 @@
 }
 
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AscGetEEPConfig(
                    PortAddr iop_base,
                    ASCEEP_CONFIG * cfg_buf, ushort bus_type
@@ -12970,7 +12963,7 @@
 }
 
 ASC_INITFUNC(
-STATIC int,
+static int,
 AscSetEEPConfigOnce(
                        PortAddr iop_base,
                        ASCEEP_CONFIG * cfg_buf, ushort bus_type
@@ -13068,7 +13061,7 @@
 }
 
 ASC_INITFUNC(
-STATIC int,
+static int,
 AscSetEEPConfig(
                    PortAddr iop_base,
                    ASCEEP_CONFIG * cfg_buf, ushort bus_type
@@ -13091,7 +13084,7 @@
     return (n_error);
 }
 
-STATIC void
+static void
 AscAsyncFix(
                ASC_DVC_VAR *asc_dvc,
                uchar tid_no,
@@ -13132,7 +13125,7 @@
     return;
 }
 
-STATIC int
+static int
 AscTagQueuingSafe(ASC_SCSI_INQUIRY *inq)
 {
     if ((inq->add_len >= 32) &&
@@ -13146,7 +13139,7 @@
     return 1;
 }
 
-STATIC void
+static void
 AscInquiryHandling(ASC_DVC_VAR *asc_dvc,
                    uchar tid_no, ASC_SCSI_INQUIRY *inq)
 {
@@ -13192,7 +13185,7 @@
     return;
 }
 
-STATIC int
+static int
 AscCompareString(
                     uchar *str1,
                     uchar *str2,
@@ -13210,7 +13203,7 @@
     return (0);
 }
 
-STATIC uchar
+static uchar
 AscReadLramByte(
                    PortAddr iop_base,
                    ushort addr
@@ -13230,7 +13223,7 @@
     }
     return (byte_data);
 }
-STATIC ushort
+static ushort
 AscReadLramWord(
                    PortAddr iop_base,
                    ushort addr
@@ -13244,7 +13237,7 @@
 }
 
 #if CC_VERY_LONG_SG_LIST
-STATIC ASC_DCNT
+static ASC_DCNT
 AscReadLramDWord(
                     PortAddr iop_base,
                     ushort addr
@@ -13261,7 +13254,7 @@
 }
 #endif /* CC_VERY_LONG_SG_LIST */
 
-STATIC void
+static void
 AscWriteLramWord(
                     PortAddr iop_base,
                     ushort addr,
@@ -13273,7 +13266,7 @@
     return;
 }
 
-STATIC void
+static void
 AscWriteLramByte(
                     PortAddr iop_base,
                     ushort addr,
@@ -13302,7 +13295,7 @@
  * The source data is assumed to be in little-endian order in memory
  * and is maintained in little-endian order when written to LRAM.
  */
-STATIC void
+static void
 AscMemWordCopyPtrToLram(
                         PortAddr iop_base,
                         ushort s_addr,
@@ -13334,7 +13327,7 @@
  * The source data is assumed to be in little-endian order in memory
  * and is maintained in little-endian order when writen to LRAM.
  */
-STATIC void
+static void
 AscMemDWordCopyPtrToLram(
                          PortAddr iop_base,
                          ushort s_addr,
@@ -13360,7 +13353,7 @@
  * The source data is assumed to be in little-endian order in LRAM
  * and is maintained in little-endian order when written to memory.
  */
-STATIC void
+static void
 AscMemWordCopyPtrFromLram(
                           PortAddr iop_base,
                           ushort s_addr,
@@ -13380,7 +13373,7 @@
     return;
 }
 
-STATIC ASC_DCNT
+static ASC_DCNT
 AscMemSumLramWord(
                      PortAddr iop_base,
                      ushort s_addr,
@@ -13397,7 +13390,7 @@
     return (sum);
 }
 
-STATIC void
+static void
 AscMemWordSetLram(
                      PortAddr iop_base,
                      ushort s_addr,
@@ -13422,7 +13415,7 @@
 /* a_mcode.h */
 
 /* Microcode buffer is kept after initialization for error recovery. */
-STATIC unsigned char _adv_asc3550_buf[] = {
+static unsigned char _adv_asc3550_buf[] = {
   0x00,  0x00,  0x00,  0xf2,  0x00,  0xf0,  0x00,  0x16,  0x18,  0xe4,  0x00,  0xfc,  0x01,  0x00,  0x48,  0xe4,
   0xbe,  0x18,  0x18,  0x80,  0x03,  0xf6,  0x02,  0x00,  0x00,  0xfa,  0xff,  0xff,  0x28,  0x0e,  0x9e,  0xe7,
   0xff,  0x00,  0x82,  0xe7,  0x00,  0xea,  0x00,  0xf6,  0x01,  0xe6,  0x09,  0xe7,  0x55,  0xf0,  0x01,  0xf6,
@@ -13739,13 +13732,13 @@
   0x18,  0xfe,  0x14,  0xf0,  0x08,  0x65,  0xfe,  0xc6,  0x18,  0x03,  0xff,  0x1a,  0x00,  0x00,
 };
 
-STATIC unsigned short _adv_asc3550_size =
+static unsigned short _adv_asc3550_size =
         sizeof(_adv_asc3550_buf); /* 0x13AD */
-STATIC ADV_DCNT _adv_asc3550_chksum =
+static ADV_DCNT _adv_asc3550_chksum =
         0x04D52DDDUL; /* Expanded little-endian checksum. */
 
 /* Microcode buffer is kept after initialization for error recovery. */
-STATIC unsigned char _adv_asc38C0800_buf[] = {
+static unsigned char _adv_asc38C0800_buf[] = {
   0x00,  0x00,  0x00,  0xf2,  0x00,  0xf0,  0x00,  0xfc,  0x00,  0x16,  0x18,  0xe4,  0x01,  0x00,  0x48,  0xe4,
   0x18,  0x80,  0x03,  0xf6,  0x02,  0x00,  0xce,  0x19,  0x00,  0xfa,  0xff,  0xff,  0x1c,  0x0f,  0x00,  0xf6,
   0x9e,  0xe7,  0xff,  0x00,  0x82,  0xe7,  0x00,  0xea,  0x01,  0xfa,  0x01,  0xe6,  0x09,  0xe7,  0x55,  0xf0,
@@ -14083,13 +14076,13 @@
   0xfe,  0xda,  0x19,  0x04,  0xff,  0xcc,  0x00,  0x00,
 };
 
-STATIC unsigned short _adv_asc38C0800_size =
+static unsigned short _adv_asc38C0800_size =
         sizeof(_adv_asc38C0800_buf); /* 0x14E1 */
-STATIC ADV_DCNT _adv_asc38C0800_chksum =
+static ADV_DCNT _adv_asc38C0800_chksum =
         0x050D3FD8UL; /* Expanded little-endian checksum. */
 
 /* Microcode buffer is kept after initialization for error recovery. */
-STATIC unsigned char _adv_asc38C1600_buf[] = {
+static unsigned char _adv_asc38C1600_buf[] = {
   0x00,  0x00,  0x00,  0xf2,  0x00,  0x16,  0x00,  0xfc,  0x00,  0x10,  0x00,  0xf0,  0x18,  0xe4,  0x01,  0x00,
   0x04,  0x1e,  0x48,  0xe4,  0x03,  0xf6,  0xf7,  0x13,  0x2e,  0x1e,  0x02,  0x00,  0x07,  0x17,  0xc0,  0x5f,
   0x00,  0xfa,  0xff,  0xff,  0x04,  0x00,  0x00,  0xf6,  0x09,  0xe7,  0x82,  0xe7,  0x85,  0xf0,  0x86,  0xf0,
@@ -14488,9 +14481,9 @@
   0x33,  0x0b,  0x77,  0x0e,  0xa8,  0x02,  0xff,  0x66,  0x00,  0x00,
 };
 
-STATIC unsigned short _adv_asc38C1600_size =
+static unsigned short _adv_asc38C1600_size =
         sizeof(_adv_asc38C1600_buf); /* 0x1673 */
-STATIC ADV_DCNT _adv_asc38C1600_chksum =
+static ADV_DCNT _adv_asc38C1600_chksum =
         0x0604EF77UL; /* Expanded little-endian checksum. */
 
 /* a_init.c */
@@ -14510,7 +14503,7 @@
  * on big-endian platforms so char fields read as words are actually being
  * unswapped on big-endian platforms.
  */
-STATIC ADVEEP_3550_CONFIG
+static ADVEEP_3550_CONFIG
 Default_3550_EEPROM_Config ASC_INITDATA = {
     ADV_EEPROM_BIOS_ENABLE,     /* cfg_lsw */
     0x0000,                     /* cfg_msw */
@@ -14548,7 +14541,7 @@
     0                           /* num_of_err */
 };
 
-STATIC ADVEEP_3550_CONFIG
+static ADVEEP_3550_CONFIG
 ADVEEP_3550_Config_Field_IsChar ASC_INITDATA = {
     0,                          /* cfg_lsw */
     0,                          /* cfg_msw */
@@ -14586,7 +14579,7 @@
     0                           /* num_of_err */
 };
 
-STATIC ADVEEP_38C0800_CONFIG
+static ADVEEP_38C0800_CONFIG
 Default_38C0800_EEPROM_Config ASC_INITDATA = {
     ADV_EEPROM_BIOS_ENABLE,     /* 00 cfg_lsw */
     0x0000,                     /* 01 cfg_msw */
@@ -14651,7 +14644,7 @@
     0                           /* 63 reserved */
 };
 
-STATIC ADVEEP_38C0800_CONFIG
+static ADVEEP_38C0800_CONFIG
 ADVEEP_38C0800_Config_Field_IsChar ASC_INITDATA = {
     0,                          /* 00 cfg_lsw */
     0,                          /* 01 cfg_msw */
@@ -14716,7 +14709,7 @@
     0                           /* 63 reserved */
 };
 
-STATIC ADVEEP_38C1600_CONFIG
+static ADVEEP_38C1600_CONFIG
 Default_38C1600_EEPROM_Config ASC_INITDATA = {
     ADV_EEPROM_BIOS_ENABLE,     /* 00 cfg_lsw */
     0x0000,                     /* 01 cfg_msw */
@@ -14781,7 +14774,7 @@
     0                           /* 63 reserved */
 };
 
-STATIC ADVEEP_38C1600_CONFIG
+static ADVEEP_38C1600_CONFIG
 ADVEEP_38C1600_Config_Field_IsChar ASC_INITDATA = {
     0,                          /* 00 cfg_lsw */
     0,                          /* 01 cfg_msw */
@@ -14855,7 +14848,7 @@
  * then 0 is returned.
  */
 ASC_INITFUNC(
-STATIC int,
+static int,
 AdvInitGetConfig(ADV_DVC_VAR *asc_dvc)
 )
 {
@@ -14998,7 +14991,7 @@
  *
  * Needed after initialization for error recovery.
  */
-STATIC int
+static int
 AdvInitAsc3550Driver(ADV_DVC_VAR *asc_dvc)
 {
     AdvPortAddr iop_base;
@@ -15578,7 +15571,7 @@
  *
  * Needed after initialization for error recovery.
  */
-STATIC int
+static int
 AdvInitAsc38C0800Driver(ADV_DVC_VAR *asc_dvc)
 {
     AdvPortAddr iop_base;
@@ -16203,7 +16196,7 @@
  *
  * Needed after initialization for error recovery.
  */
-STATIC int
+static int
 AdvInitAsc38C1600Driver(ADV_DVC_VAR *asc_dvc)
 {
     AdvPortAddr iop_base;
@@ -16842,7 +16835,7 @@
  * Note: Chip is stopped on entry.
  */
 ASC_INITFUNC(
-STATIC int,
+static int,
 AdvInitFrom3550EEP(ADV_DVC_VAR *asc_dvc)
 )
 {
@@ -17016,7 +17009,7 @@
  * Note: Chip is stopped on entry.
  */
 ASC_INITFUNC(
-STATIC int,
+static int,
 AdvInitFrom38C0800EEP(ADV_DVC_VAR *asc_dvc)
 )
 {
@@ -17251,7 +17244,7 @@
  * Note: Chip is stopped on entry.
  */
 ASC_INITFUNC(
-STATIC int,
+static int,
 AdvInitFrom38C1600EEP(ADV_DVC_VAR *asc_dvc)
 )
 {
@@ -17519,7 +17512,7 @@
  * Return a checksum based on the EEPROM configuration read.
  */
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AdvGet3550EEPConfig(AdvPortAddr iop_base, ADVEEP_3550_CONFIG *cfg_buf)
 )
 {
@@ -17567,7 +17560,7 @@
  * Return a checksum based on the EEPROM configuration read.
  */
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AdvGet38C0800EEPConfig(AdvPortAddr iop_base,
                        ADVEEP_38C0800_CONFIG *cfg_buf)
 )
@@ -17616,7 +17609,7 @@
  * Return a checksum based on the EEPROM configuration read.
  */
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AdvGet38C1600EEPConfig(AdvPortAddr iop_base,
                        ADVEEP_38C1600_CONFIG *cfg_buf)
 )
@@ -17663,7 +17656,7 @@
  * Read the EEPROM from specified location
  */
 ASC_INITFUNC(
-STATIC ushort,
+static ushort,
 AdvReadEEPWord(AdvPortAddr iop_base, int eep_word_addr)
 )
 {
@@ -17677,7 +17670,7 @@
  * Wait for EEPROM command to complete
  */
 ASC_INITFUNC(
-STATIC void,
+static void,
 AdvWaitEEPCmd(AdvPortAddr iop_base)
 )
 {
@@ -17923,7 +17916,7 @@
  *      ADV_ERROR(-1) -  Invalid ADV_SCSI_REQ_Q request structure
  *                       host IC error.
  */
-STATIC int
+static int
 AdvExeScsiQueue(ADV_DVC_VAR *asc_dvc,
                 ADV_SCSI_REQ_Q *scsiq)
 {
@@ -18054,7 +18047,7 @@
  *      ADV_ERROR(-1) - Microcode command timed-out. Microcode or IC
  *                      may be hung which requires driver recovery.
  */
-STATIC int
+static int
 AdvResetSB(ADV_DVC_VAR *asc_dvc)
 {
     int         status;
@@ -18099,7 +18092,7 @@
  *      ADV_TRUE(1) -   Chip re-initialization and SCSI Bus Reset successful.
  *      ADV_FALSE(0) -  Chip re-initialization and SCSI Bus Reset failure.
  */
-STATIC int
+static int
 AdvResetChipAndSB(ADV_DVC_VAR *asc_dvc)
 {
     int         status;
@@ -18213,7 +18206,7 @@
  *   ADV_TRUE(1) - interrupt was pending
  *   ADV_FALSE(0) - no interrupt was pending
  */
-STATIC int
+static int
 AdvISR(ADV_DVC_VAR *asc_dvc)
 {
     AdvPortAddr                 iop_base;
@@ -18381,7 +18374,7 @@
  *   ADV_FALSE - command failed
  *   ADV_ERROR - command timed out
  */
-STATIC int
+static int
 AdvSendIdleCmd(ADV_DVC_VAR *asc_dvc,
                ushort idle_cmd,
                ADV_DCNT idle_cmd_parameter)
@@ -18455,7 +18448,7 @@
  * microcode operating variables that affect WDTR, SDTR, and Tag
  * Queuing.
  */
-STATIC void
+static void
 AdvInquiryHandling(
     ADV_DVC_VAR                 *asc_dvc,
     ADV_SCSI_REQ_Q              *scsiq)

